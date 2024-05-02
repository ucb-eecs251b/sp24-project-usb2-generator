package usbtx

import chisel3._
import chisel3.util._
import _root_.circt.stage.ChiselStage

// Define states for the FSM
object TxStates {
  object State extends ChiselEnum {
    val Idle, SyncGen, DataTx, EOPGen = Value
  }
}

// Modified TxFSM with added serializer controls
class TxFSM(dWidth: Int) extends Module {
  import TxStates.State
  import TxStates.State._

  val io = IO(new Bundle {
    val tx_valid_i = Input(Bool())           // Valid input from upstream
    val tx_data_i  = Input(UInt(dWidth.W))   // Data input from upstream
    val serial_clk = Input(Clock())          // Clock input
    val tx_ready_i = Input(Bool())           // Ready input from downstream
    
    val tx_data_o  = Output(UInt(dWidth.W))  // Data output to downstream
    val tx_valid_o = Output(Bool())          // Valid output to downstream
    val tx_ready_o = Output(Bool())          // Ready output to upstream
  })

  val state   = RegInit(State.Idle)
  val data    = RegInit(0.U(32.W))
  val bit_cnt = RegInit((31.U(5.W)))

  // Initialize outputs
  io.tx_data_o := DontCare
  io.tx_valid_o := false.B
  io.tx_ready_o := false.B  // It should be false initially

  withClock(io.serial_clk) {
    switch(state) {
      is(State.Idle) {
        io.tx_ready_o := true.B  // FSM is ready to receive data
        when(io.tx_valid_i) {
          state := State.SyncGen
          data := "hAAAAAAAB".U
          io.tx_valid_o := true.B
        }
      }
      is(State.SyncGen) {
        when(io.tx_ready_i && (bit_cnt === 0.U)) {
          state := State.DataTx
        }
        when(io.tx_ready_i && (bit_cnt > 24.U && bit_cnt <= 32.U)) {
          io.tx_data_o := data(31, 24)
          bit_cnt := bit_cnt - 1.U
          state := State.SyncGen
        }.elsewhen(io.tx_ready_i && (bit_cnt > 16.U && bit_cnt <= 24.U)) {
          io.tx_data_o := data(23, 16)
          bit_cnt := bit_cnt - 1.U
          state := State.SyncGen
        }.elsewhen(io.tx_ready_i && (bit_cnt > 8.U && bit_cnt <= 16.U)) {
          io.tx_data_o := data(15, 8)
          bit_cnt := bit_cnt - 1.U
          state := State.SyncGen
        }.elsewhen(io.tx_ready_i && (bit_cnt > 0.U && bit_cnt <= 8.U)) {
          io.tx_data_o := data(7, 0)
          bit_cnt := bit_cnt - 1.U
          state := State.SyncGen
        }
      }
      is(State.DataTx) {
        io.tx_data_o  := io.tx_data_i
        io.tx_valid_o := true.B
        when(io.tx_valid_i && io.tx_ready_i) {
          state := State.EOPGen
          io.tx_data_o := "b01111111".U
          bit_cnt := 3.U
        }
      }
      is(State.EOPGen) {
        when(bit_cnt === 0.U && io.tx_ready_i) {
          state := State.Idle
          io.tx_valid_o := false.B 
        }.elsewhen(bit_cnt > 0.U && bit_cnt < 3.U) {
          bit_cnt := bit_cnt - 1.U
          io.tx_valid_o := true.B
        }.otherwise {
          bit_cnt := 0.U
          state := State.EOPGen
        }
      }
    }
  }
}

// Main USBTx module incorporating the TxFSM and USBTxSerializer
// No need for LS, the initial handshake with device must happen at FS per USB 2.0 Spec
// System clock is either: 
//   * 60 MHz HS/FS 8-bit 
//   * 30 MHz HS/FS 16-bit
//   * 48 MHz FS 8-bit
class USBTx(dWidth: Int) extends Module {
  val io = IO(new Bundle {
    val pDin_packet = Flipped(Decoupled(UInt(dWidth.W)))

    val serialClk   = Input(Clock())      // From PLL, external clock is assumed to be in phase
    val xcvrSel     = Input(UInt(1.W))    // 0: HS (480 MHz), 1: FS (12 MHz)
    val valid       = Output(UInt(1.W))   // Pull-up is low when actively communicating, not sure if valid need to be exposed
    val opMode      = Input(UInt(2.W))    // Highest priority. 
                                          // 00: Normal, 
                                          // 01: Non-driving (propagate to Tx Driver => remove termination)
                                          // 10: BitStuffing and NRZI disabled

    val fsDout      = Output(UInt(1.W))   
    val seo         = Output(UInt(1.W))
    val oe          = Output(UInt(1.W))

    val rpuEn       = Output(UInt(1.W))    // Pull-up resistor enable: Asserted when the device is ready

    val hsDout      = Output(UInt(1.W))
    val hsDriveEn   = Output(UInt(1.W))
    val hsCurrEn    = Output(Bool())
  })
  

  val fsm        = Module(new TxFSM(dWidth))
  val serializer = Module(new USBTxSerializer(dWidth))
  val bitStuffer = Module(new USBBitStuffer)
  val nrziEnc    = Module(new USBNrziEncoder)
  
  // Inputs
  fsm.io.tx_valid_i := io.pDin_packet.valid
  fsm.io.tx_data_i  := io.pDin_packet.bits
  fsm.io.serial_clk := io.serialClk

  // FSM <-> Serializer
  serializer.io.pDataIn.valid := fsm.io.tx_valid_o
  serializer.io.pDataIn.bits  := fsm.io.tx_data_o
  serializer.io.clockOut      := io.serialClk
  serializer.io.xcvrSelect    := io.xcvrSel
  fsm.io.tx_ready_i           := serializer.io.pDataIn.ready

  withClock(io.serialClk) {
    when(io.opMode === 0.U) {
      bitStuffer.io.en := true.B
      nrziEnc.io.en := true.B
    }.otherwise {
      bitStuffer.io.en := false.B
      nrziEnc.io.en := false.B
    }

    serializer.io.sDataOut <> bitStuffer.io.dataIn
    nrziEnc.io.dIn := bitStuffer.io.dataOut

    io.valid := true.B
    io.hsDout := nrziEnc.io.dOut
  }

  io.pDin_packet.ready := fsm.io.tx_ready_o

  io.rpuEn      := 1.U // Condition of pull-up resistor ?
  io.fsDout     := 0.U // No FS yet
  io.seo        := 0.U
  io.oe         := 0.U
  io.hsDriveEn  := 1.U
  io.hsCurrEn   := true.B

}

object USBTx extends App {
  ChiselStage.emitSystemVerilogFile(new USBTx(8))
}

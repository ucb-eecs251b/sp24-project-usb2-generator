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
  val data    = RegInit(0.U(dWidth.W))
  val bit_cnt = RegInit((7.U(4.W)))  // 8 bits per byte

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
          data := "b1000_0000".U  // Sync field
          io.tx_valid_o := true.B
        }
      }
      is(State.SyncGen) {
        io.tx_data_o  := DontCare
        io.tx_valid_o := true.B
        when(bit_cnt === 0.U && io.tx_ready_i) {  // Proceed only if downstream is ready
          state := State.DataTx
          io.tx_data_o := io.tx_data_i
          io.tx_valid_o := false.B  // End of Sync Phase
        }.elsewhen(bit_cnt < 7.U && bit_cnt > 0.U) {
          bit_cnt := bit_cnt - 1.U
          io.tx_valid_o := io.tx_valid_i
          state := State.SyncGen
        }.otherwise {
          bit_cnt := 0.U
          state := State.SyncGen
        }
      }
      is(State.DataTx) {
        io.tx_data_o  := DontCare
        io.tx_valid_o := io.tx_valid_i
        when(io.tx_valid_i && io.tx_ready_i) {
          state := State.EOPGen
          io.tx_data_o := "b1111_1001".U  // EOP field
          bit_cnt := 7.U
        }
      }
      is(State.EOPGen) {
        io.tx_data_o := DontCare
        when(bit_cnt === 0.U && io.tx_ready_i) {
          state := State.Idle
          io.tx_valid_o := false.B  // Ensure valid is low when transitioning to Idle
        }.elsewhen(bit_cnt > 0.U && bit_cnt < 7.U) {
          bit_cnt := bit_cnt - 1.U
          io.tx_valid_o := io.tx_valid_i
        }.otherwise {
          bit_cnt := 0.U
          state := State.EOPGen
        }
      }
    }
  }
}

// Main USBTx module incorporating the TxFSM and USBTxSerializer
class USBTx(dWidth: Int) extends Module {
  val io = IO(new Bundle {
    val pDin_packet = Flipped(Decoupled(UInt(dWidth.W)))
    val txBusy      = Output(Bool())

    // Some Analog ?
    val rpuEn       = Output(UInt(1.W))

    val serialClk   = Input(Clock())   // From PLL
    val xcvrSel     = Input(UInt(1.W)) // Essentially, set to 1
    val valid       = Output(UInt(1.W)) // Serializer valid

    val fsDout      = Output(UInt(1.W))
    val seo         = Output(UInt(1.W))
    val oe          = Output(UInt(1.W))

    val hsDout      = Output(UInt(1.W))
    val hsDriveEn   = Output(UInt(1.W))
    val hsCurrEn    = Output(Bool())
  })
  

  val fsm        = Module(new TxFSM(dWidth))
  val serializer = Module(new USBTxSerializer(dWidth))
  
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

  // Serializer <-> IO, for now
  io.hsDout := serializer.io.sDataOut.bits
  io.valid := serializer.io.sDataOut.valid
  serializer.io.sDataOut.ready := true.B  // Driver's always ready

  io.txBusy := fsm.io.tx_ready_o
  io.pDin_packet.ready := fsm.io.tx_ready_o

  io.rpuEn      := 1.U // Condition of pull-up resistor ?
  io.fsDout     := 0.U // No FS yet
  io.seo        := 0.U
  io.oe         := 0.U
  io.hsDriveEn  := 1.U
  io.hsCurrEn   := true.B

}

object USBTx extends App {
  ChiselStage.emitSystemVerilogFile(new USBTx(16))
}

package usbtx

import chisel3._
import chisel3.util._
import _root_.circt.stage.ChiselStage

/**
  * @param xcvrSelec Tranceiver select signal: 0 (HS, 480 MHz serial clock), 1 (FS, 12 MHz serial clock)       
  * @param pDataIn   Parallel data input, can be 8 or 16 bits wide
  * @param sDataOut  Serial data output
  * @param clockOut  Serial clock output from the on-chip PLL (Async Queue is required to cross clock domains, if not in-phase with implicit clock)
  *
  */
class USBTxSerializer(dWidth: Int) extends Module {
  val io = IO(new Bundle {
    val pDataIn     = Flipped(Decoupled(UInt(dWidth.W))) 
    val sDataOut    = Decoupled(UInt(1.W))               
    val clockOut    = Input(Clock())                    

    val xcvrSelect  = Input(UInt(1.W))  //  
  })

  val fifo = Module(new Queue(UInt(dWidth.W), 16))
  fifo.io.enq <> io.pDataIn

  withClock(io.clockOut) {
    val shiftReg      = RegInit(0.U(dWidth.W))
    val bitCounter    = RegInit(0.U(log2Ceil(dWidth + 1).W))
    val dataReady     = RegInit(false.B)

    fifo.io.deq.ready := !dataReady
    io.sDataOut.bits := 0.U

    when(fifo.io.deq.valid && !dataReady) {
      shiftReg := fifo.io.deq.bits
      bitCounter := 0.U
      dataReady := true.B
    }

    when(dataReady) {
      io.sDataOut.bits  := shiftReg(0)
      io.sDataOut.valid := true.B
      shiftReg          := shiftReg >> 1
      bitCounter        := bitCounter + 1.U
      when(bitCounter === 7.U) {
        dataReady := false.B
        io.sDataOut.valid := false.B
      }
    }.otherwise {
      io.sDataOut.valid := false.B
    }
  }
}

object USBTxSerializer extends App {
  ChiselStage.emitSystemVerilogFile(new USBTxSerializer(16))
}

package usbtx

import chisel3._
import chisel3.util._
import _root_.circt.stage.ChiselStage

class USBTxSerializer(dWidth: Int) extends Module {
  val io = IO(new Bundle {
    val pDataIn     = Flipped(Decoupled(UInt(dWidth.W))) 
    val sDataOut    = Decoupled(UInt(1.W))               
    val clockOut    = Input(Clock())                    

    val xcvrSelect  = Input(UInt(1.W))  //  0: HS, 480 MHz, 1: FS, 12 MHz
  })

  io.sDataOut.bits := 0.U
  io.sDataOut.valid := false.B

  val fifo = Module(new Queue(UInt(dWidth.W), 16))
  fifo.io.enq <> io.pDataIn
  fifo.io.deq.ready := false.B

  withClock(io.clockOut) {
    val shiftReg   = RegInit(0.U(dWidth.W))
    val bitCounter = RegInit(0.U(log2Ceil(dWidth + 1).W))
    val dataReady  = RegInit(false.B)

    when(fifo.io.deq.valid && !dataReady) {
      shiftReg := fifo.io.deq.bits
      fifo.io.deq.ready := true.B
      bitCounter := 0.U
      dataReady := true.B
    }.otherwise { 
      fifo.io.deq.ready := false.B
    }                             

    when(dataReady) {
      shiftReg := shiftReg >> 1
      bitCounter := bitCounter + 1.U
      when(bitCounter === (7).U) {
        dataReady := false.B
        io.sDataOut.valid := false.B
      }
    }

  }
}

object USBTxSerializer extends App {
  ChiselStage.emitSystemVerilog(new USBTxSerializer(16))
}

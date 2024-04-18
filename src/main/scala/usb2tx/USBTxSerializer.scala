package usb2

import chisel3._
import chisel3.util._

class USBTxSerializer(dWidth: Int) extends Module {
  val io = IO(new Bundle {
    val parallelDataIn = Input(UInt(dWidth.W))
    val load = Input(Bool())

    val serialDataOut = Output(Bool())
    val valid = Output(Bool())
  })

  val shiftRegister = RegInit(0.U(dWidth.W))
  val bitCtr = RegInit(0.U(log2Ceil(dWidth + 1).W))

  when(io.load) {
    shiftRegister := io.parallelDataIn
    bitCtr := 0.U
  }.otherwise {
    when(bitCtr < dWidth.U) {
      shiftRegister := shiftRegister >> 1
      bitCtr := bitCtr + 1.U
    }
  }

  io.serialDataOut := shiftRegister(0)
  io.valid := bitCtr > 0.U && bitCtr <= dWidth.U
  
  when(bitCtr === dWidth.U) {
    shiftRegister := 0.U
  }
}

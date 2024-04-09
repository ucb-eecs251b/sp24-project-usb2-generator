package usb2

import chisel3._
import chisel3.util._

class Usb2tx_serializer(dWidth: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn    = Input(UInt(dWidth.W))
    val load      = Input(Bool())

    val dataOut   = Output(Bool())
    val valid     = Output(Bool())
  })

  val shiftRegister = RegInit(0.U(dWidth.W))
  val validReg      = RegInit(false.B)

  when(io.load) {
    shiftRegister := io.dataIn
    validReg := true.B
  }.otherwise {
    when(validReg) {
      shiftRegister := shiftRegister >> 1
      when(shiftRegister === 1.U) {
        validReg := false.B
      }
    }
  }

  io.dataOut := shiftRegister(0)
  io.valid   := validReg
}

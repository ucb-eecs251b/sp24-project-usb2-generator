package usb2

import chisel3._
import chisel3.util._

class Usb2tx_serializer(dWidth: Int) extends Module {
  val io = IO(new Bundle {
    val din_p   = Input(UInt(dWidth.W))
    val load    = Input(Bool())

    val dout_s  = Output(Bool())
    val valid   = Output(Bool())
  })

  val shiftRegister = RegInit(0.U(dWidth.W))
  val validReg = RegInit(false.B)

  when(io.load) {
    shiftRegister := io.din_p
    validReg := true.B
  }.otherwise {
    when(validReg) {
      shiftRegister := shiftRegister >> 1
      when(shiftRegister === 1.U) {
        validReg := false.B
      }
    }
  }

  io.dout_s := shiftRegister(0) // Output the LSB
  io.valid := validReg
}

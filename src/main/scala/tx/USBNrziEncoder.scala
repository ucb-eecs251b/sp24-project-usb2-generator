package usbtx

import chisel3._
import _root_.circt.stage.ChiselStage

class USBNrziEncoder extends Module {
  val io = IO(new Bundle {
    val en   = Input(Bool())
    val dIn  = Input(UInt(1.W))
    val dOut = Output(UInt(1.W))
  })

  val lastState = RegInit(1.U(1.W))

  when(io.en) {
    when(io.dIn === 1.U) {
      /* If dataIn is '1' -> no change in output (maintain last state) */
      io.dOut := lastState
    }.otherwise {
      /* If '0', invert the output */
      io.dOut := !lastState
    }
  }.otherwise {
    io.dOut := io.dIn
  }

  /* Update for the next cycle */
  lastState := io.dOut
}

object USBNrziEncoder extends App {
  ChiselStage.emitSystemVerilogFile(new USBNrziEncoder)
}

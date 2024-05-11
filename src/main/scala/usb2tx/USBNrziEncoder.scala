package usb2

import chisel3._
import chisel3.util._
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
      // dataIn == 1 -> maintain prev val
      io.dOut := lastState
    }.otherwise {
      // dataIn == 0 -> invert prev val
      io.dOut := !lastState
    }
  }.otherwise {
    io.dOut := io.dIn
  }

  lastState := io.dOut
}

// object USBNrziEncoder extends App {
//   def apply[T <: Data](en: Bool, dIn: T): UInt = {
//     val n = Module(new USBNrziEncoder)
//     n.io.en := en
//     n.io.dIn := dIn
//     n.io.dOut
//   }

//   //ChiselStage.emitSystemVerilogFile(new USBNrziEncoder)
// }

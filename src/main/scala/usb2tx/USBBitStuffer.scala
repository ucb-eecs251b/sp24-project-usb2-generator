package usb2

import chisel3._
import chisel3.util._
import _root_.circt.stage.ChiselStage

/** USBBitStuffer
  *
  * Inserts the incoming with a 0 after 6 consecutive 1s.
  * It is assumed that the upstream module pauses transmission then stuffer isn't ready
  *
  * @param dataIn  : ready-valid from serializer
  * @param dataOut : ready-valid to NRZI encoder
  */

class USBBitStuffer extends Module {
  val io = IO(new Bundle {
    /** Enable global to pass-through 
     *  This is specified in the UTMI spec. doc
     */
    val en = Input(Bool())
    val dataIn = Flipped(Decoupled(UInt(1.W)))
    val dataOut = Output(UInt(1.W))
  })

  val count = RegInit(0.U(3.W))
  val stuffing  = RegInit(false.B)

  io.dataIn.ready  := true.B
  io.dataOut := DontCare

  when(io.en) {
    when(io.dataIn.valid) {

      when(stuffing) {
        
        stuffing := false.B
        io.dataOut := 0.U
        io.dataIn.ready := true.B

      }.elsewhen(count === 5.U && io.dataIn.bits === 1.U) {

        stuffing := true.B
        io.dataOut := io.dataIn.bits
        count := 0.U
        io.dataIn.ready := false.B

      }.otherwise {

        io.dataIn.ready := true.B
        io.dataOut := io.dataIn.bits
        count := Mux(io.dataIn.bits === 1.U, count + 1.U, 0.U)

      }

    }.otherwise {
      
      io.dataIn.ready := true.B
      io.dataOut := DontCare
      count := 0.U

    }

  }.otherwise {
    /* Pass-through when disabled */
    io.dataOut := io.dataIn.bits
  }

}

// object USBBitStuffer extends App{  // App inheritance for testing, remove later
//   def apply[T <: Data](en: Bool, dataIn: DecoupledIO[T]): UInt = {
//     val b = Module(new USBBitStuffer)
//     b.io.en := en
//     b.io.dataIn.valid := dataIn.valid
//     b.io.dataIn.bits := dataIn.bits
//     dataIn.ready := b.io.dataIn.ready
//     b.io.dataOut
//   }

//   ChiselStage.emitSystemVerilogFile(new USBBitStuffer)
// }

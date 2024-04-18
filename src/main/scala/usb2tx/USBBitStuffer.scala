package usb2

import chisel3._
import chisel3.util._

/** USBBitStuffer
  *
  * This module is used to insert the incoming with a 0 after 6 consecutive 1s.
  * Not sure if decoupled ready-valid is the best way to do it.
  * Could be a rigid coupling is the best way to do it.
  *
  * @param dataIn  : input from the serializer
  * @param dataOut : output to NRZI
  */

class USBBitStuffer extends Module {
  val io = IO(new Bundle {
    /** Enable global to pass-through 
     *  This is specified in the UTMI spec. doc
     */
    val en = Input(Bool())
    /** Data in from the serializer (fifo ?) */
    val dataIn = Flipped(Decoupled(Bool()))
    val dataOut = Decoupled(Bool())
  })

  val count     = RegInit(0.U(3.W))
  val stuffing  = RegInit(false.B)

  when(io.enable) {
    when(io.dataIn.valid && io.dataOut.ready) {
      when(stuffing) {

        io.dataOut.bits := false.B
        stuffing        := false.B
        io.dataIn.ready := true.B

      }.elsewhen(count === 6.U && io.dataIn.bits) {

        stuffing := true.B
        io.dataOut.bits := io.dataIn.bits
        count           := 0.U
        io.dataIn.ready := false.B

      }.otherwise {

        io.dataOut.bits := io.dataIn.bits
        count := Mux(io.dataIn.bits, count + 1.U, 0.U)
        io.dataIn.ready := true.B

      }
      io.dataOut.valid := true.B
    }.otherwise {

      io.dataOut.valid := false.B
      io.dataIn.ready := true.B
      stuffing := false.B
      count := 0.U

    }
  }.otherwise {
    /* Pass-through when disabled */
    io.dataOut.bits   := io.dataIn.bits
    io.dataOut.valid  := io.dataIn.valid
    io.dataIn.ready   := io.dataOut.ready
  }

}


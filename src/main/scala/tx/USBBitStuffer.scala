package usbtx

import chisel3._
import chisel3.util._
import _root_.circt.stage.ChiselStage

/** USBBitStuffer
  *
  * This module is used to insert the incoming with a 0 after 6 consecutive 1s.
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
    /** Data in from the serializer (fifo ?) */
    val dataIn = Flipped(Decoupled(UInt(1.W)))
    val dataOut = Decoupled(UInt(1.W))
    //val cnt = Output(UInt(3.W))
  })

  val count = RegInit(0.U(3.W))
  val stuffing  = RegInit(false.B)
  //io.cnt    := count

  io.dataIn.ready  := true.B
  io.dataOut.valid := false.B
  io.dataOut.bits  := DontCare

  when(io.en) {
    when(io.dataIn.valid && io.dataOut.ready) {

      when(stuffing) {
        
        stuffing := false.B
        io.dataOut.bits := 0.U
        io.dataIn.ready := true.B

      }.elsewhen(count === 5.U && io.dataIn.bits === 1.U) {

        stuffing := true.B
        io.dataOut.bits := io.dataIn.bits
        count := 0.U
        io.dataIn.ready := false.B

      }.otherwise {

        io.dataOut.valid := true.B
        io.dataIn.ready := true.B
        io.dataOut.bits := io.dataIn.bits
        count := Mux(io.dataIn.bits === 1.U, count + 1.U, 0.U)

      }

    }.otherwise {
      
      io.dataOut.valid := false.B
      io.dataIn.ready := io.dataOut.ready
      io.dataOut.bits := DontCare
      count := 0.U

    }

  }.otherwise {
    /* Pass-through when disabled */
    io.dataOut.bits  := io.dataIn.bits
    io.dataOut.valid := io.dataIn.valid
    io.dataIn.ready  := io.dataOut.ready
  }

}

object USBBitStuffer extends App {
  ChiselStage.emitSystemVerilogFile(new USBBitStuffer)
}

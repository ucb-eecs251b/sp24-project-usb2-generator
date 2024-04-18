package usb2

import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.subsystem._
import freechips.rocketchip.tilelink._

class USBTx(dWidth: Int) extends Module {
  /**  Explicit parameterization might not be needed
    *  Otherwise can use dWidth/2 (with requrire(dWidth % 2 == 0))
    */
  val io = IO(new Bundle {
    /** UTMI signals */
    val validH = Input(Bool())

    val in = Flipped(Decoupled(UInt(dWidth.W)))

    val tx_busy = Output(Bool())

    /**  TX driver signals */
    /* Pull-up resistor enable */
    val rpuEn     = Output(UInt(1.W))
    val vpo       = Output(UInt(1.W))
    val oeb       = Output(UInt(1.W))
    val hsData    = Output(UInt(1.W))
    val hsDriveEn = Output(UInt(1.W))
    val hsCsEn    = Output(UInt(1.W))
  })

  /** FSM */
  val txFSM = Module(new Usb2tx_fsm(io.validH, io.in.valid, io.in.bits))

  val serializer  = Module(new Usb2tx_serializer(dWidth))
  val bitStuffer  = Module(new Usb2tx_bitstuffer(serializer.io.dataOut))
  val nrziEncoder = Module(new Usb2tx_nrzi(bitStuffer.io.dataOut))

  /** Output assignment */
}

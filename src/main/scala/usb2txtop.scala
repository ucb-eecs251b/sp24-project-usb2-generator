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
    /** UTMI signals 
     *  validH is incorporated in 'in' as in.valid */
    val in = Flipped(Decoupled(UInt(dWidth.W)));

    /** Not sure if needed */
    val tx_busy = Output(Bool());

    /**  TX driver signals */
    /* Pull-up resistor enable */
    val rpuEn     = Output(UInt(1.W));
    val vpo       = Output(UInt(1.W));
    val oeb       = Output(UInt(1.W));
    val hsData    = Output(UInt(1.W));
    val hsDriveEn = Output(UInt(1.W));
    val hsCsEn    = Output(UInt(1.W));
  })

}

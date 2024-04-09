package usb2

import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.subsystem._
import freechips.rocketchip.tilelink._

class Usb2TxTop(dWidth: Int) extends Module {
  /**  Explicit parameterization might not be needed
    *  Otherwise can use dWidth/2 (with requrire(dWidth % 2 == 0))
    */
  val io = IO(new Bundle {
    /** UTMI signals
      *  INPUT
      */
    val din_lo8 = Input(UInt(8.W))
    val din_hi8 = Input(UInt(8.W))
    val valid_h = Input(Bool())

    /** Use queue instead ? */
    val tx_ready_o = Output(Bool())
    val tx_valid_i = Input(Bool())


    /**  TX driver signals
      *  OUTPUT 
      */
    val rpu_en      = Output(Bool())
      
    val vpo         = Output(Bool())
    val oeb         = Output(Bool())
    val hs_data     = Output(Bool())
    val hs_drive_en = Output(Bool())
    val hs_cs_en    = Output(Bool())
  })
}

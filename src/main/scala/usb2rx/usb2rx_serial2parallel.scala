package usb2

// Standard imports
import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.subsystem._
import freechips.rocketchip.tilelink._

import chisel3.experimental.{IntParam, BaseModule}
import chisel3.experimental.{withClock, withReset, withClockAndReset} // Might not need
import freechips.rocketchip.prci._
import freechips.rocketchip.util.UIntIsOneOf
import dataclass.data

/* 
 * Serial To Parallel Converter 
 *  
 * The serial-to-parallel conversion block takes serial data 
 * with an arbitrary clock (usually 480 (HS) or 48 (FS) MHz) received from the analog front-
 * end and CRDU and converts it to 16-bit parallel data (i.e. typically 30Mhz
 * or 0.75MHz), deserializing the data, usually using a small
 * shift register or buffer design. The clock and reset for this block 
 * will be defined by WithClockandReset wrapper in usb2rx_top.scala.
 * Note: Chisel Test doesn't support mutli-clock designs. Not sure how to test this block. 
 */
class Serial2ParallelConverter(val dataWidth: Int = 16) extends Module {
    val io = IO(new Bundle {
        val dataOut = Output(UInt(dataWidth.W)) //parallel output 
        val dataIn = Input(UInt(1.W)) //serial data
    })
    val shiftReg = RegInit(0.U(dataWidth.W))
    val holdReg = RegInit(0.U(dataWidth.W))

    shiftReg := Cat(shiftReg(dataWidth-2, 0), io.dataIn)
    holdReg := shiftReg
    io.dataOut := holdReg
}

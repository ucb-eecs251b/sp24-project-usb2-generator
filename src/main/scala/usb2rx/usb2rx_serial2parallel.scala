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

/* 
 * Serial To Parallel Converter 
 *  
 * The serial-to-parallel conversion block takes serial data 
 * with an arbitrary clock (usually 480 (HS) or 12 (FS) MHz) received from the analog front-
 * end and CRDU and converts it to 16-bit parallel data (i.e. typically 30Mhz
 * or 0.75MHz), deserializing the data, usually using a small
 * shift register or buffer design.
 * 
 */
class Serial2ParallelConverter(val dataWidth: Int = 16) extends Module {
    val io = IO(new Bundle {
        val dataout = Output(UInt(dataWidth.W))
        val datain = Input(UInt())
        val reset = Input(UInt()) 
        val clk = Input(Clock())
    })

    // Buffer with an implicit reset to 0
    val buffer = RegInit(UInt(dataWidth.W), 0.U)
    buffer := buffer << 1 + io.datain
    dataout := buffer
}

/* Basic Chisel sanity test */
for (i <- Seq(8, 16)) {
    println(s"Testing Serial2ParallelConverter dataWidth=$i")
    test(new Serial2ParallelConverter) { mod =>
        val inSeq = Seq(0, 1, 1, 1, 0, 1, 1, 0, 0, 1)
        var state = 0
        var i = 0
        for (i <- 10 * mod.dataWidth) {fsd
            // poke in repeated inSeq
            val toPoke = inSeq(i % inSeq.length)
            mod.io.datain.poke((toPoke != 0).B)
            // update expected state
            state = ((state * 2) + toPoke) 
            mod.clock.step(1)
            c.io.out.expect(state.U)
        }
    }
}
println(s"Testing Serial2ParallelConverter: Success")
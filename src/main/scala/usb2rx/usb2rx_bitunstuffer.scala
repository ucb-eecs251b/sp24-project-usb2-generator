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
 * Bit Unstuffer
 *  
 * The bit unstuffing block strips the stuffed zero 
 * bits and detects bit stuff errors. A zero is inserted after every six 
 * consecutive ones in the data stream before the data is NRZI encoded, 
 * to force a transition in the NRZI data stream, so the receiver logic 
 * transitions once every seven bits.
 */

class BitUnstuffer(dataWidth: Int) extends Module {
    val io = IO(new Bundle {
        val dataout = Output(UInt());
        val datain = Input(UInt());         
        val reset = Input(UInt()); 
        val clk = Input(Clock());
    })
    
    // Buffer with an implicit reset to 0
    val buffer = RegInit(UInt(6.W), 0.U)
    // If six consecutive 1s, send a 0 and reset
    when(buffer === 63.U ) {  // 63 is decimal for 111_111
        buffer := 0.U
        io.dataout := 0.U
    }
    // If a 0 appears, send datain and reset 
    .elsewhen(io.datain === 0.U) {
        buffer := 0.U
        io.dataout := io.datain
    }
    // Else send datain and shift registers
    .otherwise {
        buffer := buffer << 1 + io.datain
        io.dataout := io.datain
    }
}

println(s"Testing BitUnstuffer")
// Plz test me xd
println(s"Testing NRZIDecoder: Not Implemented")
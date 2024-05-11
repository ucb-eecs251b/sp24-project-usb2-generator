package usb2

// Standard imports
import chisel3._
import chisel3.util._
// import org.chipsalliance.cde.config.{Parameters, Field, Config}
// import freechips.rocketchip.diplomacy._
// import freechips.rocketchip.regmapper._
// import freechips.rocketchip.subsystem._
// import freechips.rocketchip.tilelink._

// import chisel3.experimental.{IntParam, BaseModule}
// import chisel3.experimental.{withClock, withReset, withClockAndReset} // Might not need
// import freechips.rocketchip.prci._
// import freechips.rocketchip.util.UIntIsOneOf

/* 
 * NRZI Decoder
 *  
 * The NRZI (Non Return to Zero Invert) decoding block decodes 
 * the incoming serial data. In NRZI encoding, a “1” is represented 
 * by no change in level and a “0” is represented by a change in level.
 * The clock and reset for this block will be defined by WithClockandReset
 * wrapper in usb2rx_top.scala.
 */

class NRZIDecoder extends Module {
    val io = IO(new Bundle {
        val dataOut = Output(UInt(1.W))
        val dataIn = Input(UInt(1.W))  
        val enable = Input(UInt(1.W))       
    })
    
    // Buffer with an implicit reset to 0
    val prev = RegInit(1.U(1.W))
    when (io.enable === 1.U) {
        io.dataOut := ~(io.dataIn ^ prev)
        prev := io.dataIn
    }.otherwise {
        io.dataOut := 0.U
    }
    
}



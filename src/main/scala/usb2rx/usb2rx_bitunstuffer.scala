package usb2

// Standard imports
import chisel3._
import chisel3.util._
// import org.chipsalliance.cde.config.{Parameters, Field, Config}
// import freechips.rocketchip.diplomacy._
// import freechips.rocketchip.regmapper._
// import freechips.rocketchip.subsystem._
// import freechips.rocketchip.tilelink._

// //import chisel3.experimental.{IntParam, BaseModule}
// //import chisel3.experimental.{withClock, withReset, withClockAndReset} // Might not need
// import freechips.rocketchip.prci._
// import freechips.rocketchip.util.UIntIsOneOf

/* 
 * Bit Unstuffer
 *  
 * The bit unstuffing block strips the stuffed zero 
 * bits and detects bit stuff errors. A zero is inserted after every six 
 * consecutive ones in the data stream before the data is NRZI encoded, 
 * to force a transition in the NRZI data stream, so the receiver logic 
 * transitions once every seven bits.
 */

class BitUnstuffer extends Module {
    val io = IO(new Bundle {
        val error = Output(UInt(1.W))     // bit stuffing error
        val valid = Output(UInt(1.W))      // bit stuffing inserts a 0 bit, we should ignore it in the S2P if it is bit stuffed
        val dataOut = Output(UInt(1.W))   
        val dataIn = Input(UInt(1.W))     // from NRZI (decoded data)  
        val enable = Input(UInt(1.W))   
    })
    // 6 consecutive ones you add a stuffed bit, so remove that.
    val dataReg = RegInit(0.U(7.W))
    when (io.enable === 1.U) {
        dataReg := Cat(dataReg(5, 0), io.dataIn)
    }
    io.error := ((dataReg === "h7F".U) && (io.dataIn =/= 0.U)) // 7th bit is not zero 
    io.dataOut := io.dataIn
    // unstuff the bit if 7th bit is 0 after 6 consecutive 1s
    when ((io.dataIn === 0.U) && (dataReg === "h3F".U)) { 
        io.valid := 0.U
        dataReg := 0.U
    }.elsewhen(io.enable === 1.U) {
        io.valid := 1.U
    }.otherwise {
        io.valid := 0.U
    }
}

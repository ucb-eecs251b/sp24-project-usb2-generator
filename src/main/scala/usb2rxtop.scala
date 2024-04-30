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
//import chisel3.experimental.{withClock, withReset, withClockAndReset} // Might not need
import freechips.rocketchip.prci._
import freechips.rocketchip.util.UIntIsOneOf

class Usb2RxTop(dataWidth: Int) extends Module {
    val io = IO(new Bundle {
        // UTMI Outputs - renamed to same names as usb2.scala
        val utmi_dataout = Output(SInt(dataWidth.W)); // Note that usb2.scala currently says 8-bit?  
        // val utmi_datain = Input(SInt(dataWidth.W)); // Need to discuss bidirectionality
        val utmi_rx_valid = Output(UInt()); // Dataout is valid
        val utmi_rx_active = Output(UInt()); // High when state machine detects SYNC packet in data
        val utmi_rx_error = Output(UInt()); // High when the Rx block catches invalid data etc
        // Needs to be discussed more, not at usb2.scala:
        // val utmi_linestate = Output(UInt(2.W)); // Reflects current state of the single ended receivers
        
        // UTMI Inputs
        val utmi_reset = Input(UInt());
        val utmi_clk = Input(Clock()); // How do we deal with implicit chisel clock if two clocks? is this unndeeded?

        // Of the below, for now we can assume cru_hs_v and cru_clk are provided

        // Input from Rx Front End (needs to be discussed)
        // val cru_fs_v = Input(SInt()); // Non-differential full-speed single-ended receive data

        val cru_fs_vp = Input(SInt()); // Full-speed single-ended receive data, positive terminal
        val cru_fs_vm = Input(SInt()); // Full-speed single-ended receive data, negative terminal
         // Input from Clock Recovery Unit (needs to be discussed)
        // val cru_hs_v = Input(SInt()); // Non-differential high-speed single-ended receive data

        val cru_hs_vp = Input(SInt()); // High-speed single-ended receive data, positive terminal
        val cru_hs_vm = Input(SInt()); // High-speed single-ended receive data, negative terminal

        val cru_hs_toggle = Input(UInt()); // High if HS (CDRU)
        val cru_clk = Input(Clock()); // Again might be unneeded due to implicit
    })

    /* Differential Handling */

    // Optional

    /* High Speed Mode */
    /*
    withClockAndReset(io.utmi_clk, io.utmi_reset) { // 30 MHz HS; UTMI side
        val RxStateMachine =  Module(new RxStateMachine(dataWidth));
    }
    withClock(io.cru_clk) { // 480 MHz HS; CRU side
        val NRZIDecoder =  Module(new NRZIDecoder(dataWidth));
        val BitUnstuffer =  Module(new BitUnstuffer(dataWidth));
        val Serial2ParallelConverter =  Module(new Serial2ParallelConverter(dataWidth));
    }
    */

    /* Fast Speed Mode */

    // Optional

}


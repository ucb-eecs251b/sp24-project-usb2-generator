package usb2

// Standard imports
import chisel3._
import java.io.Serial
//import chisel3.util._
//import org.chipsalliance.cde.config.{Parameters, Field, Config}
// import freechips.rocketchip.diplomacy._
// import freechips.rocketchip.regmapper._
// import freechips.rocketchip.subsystem._
// import freechips.rocketchip.tilelink._

//import chisel3.experimental.{IntParam, BaseModule}
//import chisel3.experimental.{withClock, withReset, withClockAndReset} // Might not need
// import freechips.rocketchip.prci._
// import freechips.rocketchip.util.UIntIsOneOf

class Usb2RxTop(val dataWidth: Int = 16) extends Module {
    val io = IO(new Bundle {
        // UTMI Outputs - renamed to same names as usb2.scala
        val utmi_dataout = Output(SInt(dataWidth.W)); // Output data
        val utmi_rx_valid = Output(UInt(1.W)); // Dataout is valid
        val utmi_rx_active = Output(UInt(1.W)); // High when state machine detects SYNC packet in data
        val utmi_rx_error = Output(UInt(1.W)); // High when the Rx block catches invalid data etc
        val utmi_linestate = Output(UInt(2.W)); // Reflects current state of the single ended receivers
        
        // Assuming that something will give us the appropriate D+ and D- depending on the mode (cru_hs_toggle).
        val data_j = Input(UInt(1.W))  // D+
        val data_k = Input(UInt(1.W))  // D-
        val reset = Input(Reset()); 
        val clk = Input(Clock()); // 480 MHz

        val cru_hs_toggle = Input(UInt(1.W)); // High if HS (CDRU?)
    })

    /* Differential Handling */
    // TODO: Handle Linestate according to Rohan 
    // io.utmi_linestate :=

    withClockAndReset(io.clk, io.reset) { 
        val NRZIDecoder =  Module(new NRZIDecoder());
        NRZIDecoder.io.dataIn := io.data_j
        
        val BitUnstuffer =  Module(new BitUnstuffer());
        BitUnstuffer.io.dataIn := NRZIDecoder.io.dataOut 
        
        val Serial2ParallelConverter =  Module(new Serial2ParallelConverter(dataWidth));
        Serial2ParallelConverter.io.dataIn := BitUnstuffer.io.dataOut
        Serial2ParallelConverter.io.valid := BitUnstuffer.io.valid
        
        val RxStateMachine =  Module(new RxStateMachine(dataWidth));
        RxStateMachine.io.datain := Serial2ParallelConverter.io.dataOut
        RxStateMachine.io.hs_toggle := io.cru_hs_toggle
        RxStateMachine.io.bitunstufferror := BitUnstuffer.io.error
        RxStateMachine.io.serial_ready := Serial2ParallelConverter.io.ready
        io.utmi_dataout := RxStateMachine.io.dataout
        io.utmi_rx_active := RxStateMachine.io.rx_active
        io.utmi_rx_error := RxStateMachine.io.rx_error
        io.utmi_rx_valid := RxStateMachine.io.rx_valid
        
    }
}

class RxStateMachine(dataWidth: Int) extends Module {
    val io = IO(new Bundle {
        val dataout = Output(UInt(dataWidth.W)) // Note that usb2.scala currently says 8-bit?  
        val datain = Input(UInt(dataWidth.W)) // Need to discuss bidirectionality 

        val rx_valid = Output(UInt(1.W)) // Dataout is valid
        val rx_active = Output(UInt(1.W)) // High when state machine detects SYNC packet in data
        val rx_error = Output(UInt(1.W)) // High when the Rx block catches invalid data etc
        val serial_ready = Input(UInt(1.W))
        val bitunstufferror = Input(UInt(1.W))

        val hs_toggle = Input(UInt(1.W)) // High if HS (CDRU)
    })

    object State extends ChiselEnum {
        val RX_WAIT, STRIP_EOP, STRIP_SYNC,
            RX_DATA, ERROR, ABORT, TERMINATE = Value
    }

    val state = RegInit(State.RX_WAIT) // inital state
        switch(state) {
            // is(State.RESET) {
            //     when(io.in) {
            //         state := State.sOne1
            //     }
            // }
            is(State.RX_WAIT) {
                when(io.in) {
                    state := State.sOne1
                }
            }
            is(State.STRIP_SYNC) {
                when(io.in) {
                    state := State.sTwo1s
                }.otherwise {
                    state := State.sNone
                }
            }
            is(State.RX_DATA) {
                when(!io.in) {
                    state := State.sNone
                }
            }
            is(State.STRIP_EOP) {
                when(!io.in) {
                    state := State.sNone
                }
            }
            is(State.ERROR) {
                when(!io.in) {
                    state := State.sNone
                }
            }
            is(State.ABORT) {
                when(!io.in) {
                    state := State.sNone
                }
            }
            is(State.TERMINATE) {
                when(!io.in) {
                    state := State.sNone
                }
            }
        
    }
}

package usb2

// Standard imports
import chisel3._
import java.io.Serial
import chisel3.util._
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
        val utmi_dataout = Output(UInt(dataWidth.W)); // Output data
        val utmi_rx_valid = Output(UInt(1.W)); // Dataout is valid
        val utmi_rx_active = Output(UInt(1.W)); // High when state machine detects SYNC packet in data
        val utmi_rx_error = Output(UInt(1.W)); // High when the Rx block catches invalid data etc
        val utmi_linestate = Output(UInt(2.W)); // Reflects current state of the single ended receivers
        
        // Assuming that something will give us the appropriate D+ and D- depending on the mode (cru_hs_toggle).
        val data_d_plus = Input(UInt(1.W));  // D+
        val data_d_minus = Input(UInt(1.W));  // D-
        val reset = Input(Reset()); 
        val clk = Input(Clock()); // 480 MHz
        //val squelch = Input(UInt(1.W)); // Squelch for linestate HS mode

        val cru_hs_toggle = Input(UInt(1.W)); // XcvrSelect = 0
    })

    withClockAndReset(io.clk, io.reset) { 
        val NRZIDecoder =  Module(new NRZIDecoder())
        NRZIDecoder.io.dataIn := io.data_d_plus 
        
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
        RxStateMachine.io.reset := io.reset
        RxStateMachine.io.data_d_plus := io.data_d_plus
        RxStateMachine.io.data_d_minus := io.data_d_minus
        //RxStateMachine.io.squel := io.squelch

        io.utmi_linestate := RxStateMachine.io.linestate 
        io.utmi_dataout := RxStateMachine.io.dataout
        io.utmi_rx_active := RxStateMachine.io.rx_active
        io.utmi_rx_error := RxStateMachine.io.rx_error
        io.utmi_rx_valid := RxStateMachine.io.rx_valid
        
    }
}

class RxStateMachine(dataWidth: Int) extends Module {
    val io = IO(new Bundle {
        val dataout = Output(UInt(dataWidth.W)) // Unidirectional  
        val datain = Input(UInt(dataWidth.W)) // Unidirectional 
        val reset = Input(Reset())
        val rx_valid = Output(UInt(1.W)) // Dataout is valid
        val rx_active = Output(UInt(1.W)) // High when state machine detects SYNC packet in data
        val rx_error = Output(UInt(1.W)) // High when the Rx block catches invalid data etc
        val serial_ready = Input(UInt(1.W))  // S2P is ready
        val bitunstufferror = Input(UInt(1.W)) // Bit unstuffing error
        val error = Input(UInt(1.W))           // SE1
        val hs_toggle = Input(UInt(1.W)) // High if HS (CDRU)
        val idle = Input(UInt(1.W))   // idle state beginning
        val data_d_plus = Input(UInt(1.W)) // D+
        val data_d_minus = Input(UInt(1.W)) // D-
        val linestate = Output(UInt(2.W)) 
        //val squel = Input(UInt(1.W)) // High Pass 
    })
    
    // SYNC, EOP, Linestate Handler 
    val SYNC_EOP_LS =  Module(new SYNC_EOP_LS());
    SYNC_EOP_LS.io.data_d_plus := io.data_d_plus
    SYNC_EOP_LS.io.data_d_minus := io.data_d_minus
    SYNC_EOP_LS.io.hs_toggle := io.hs_toggle
    io.linestate := SYNC_EOP_LS.io.linestate

    object State extends ChiselEnum {
        val RX_RESET, RX_WAIT, STRIP_EOP, STRIP_SYNC,
            RX_DATA, ERROR, ABORT1, ABORT2, TERMINATE = Value
    }

    val state = RegInit(State.RX_RESET) // initial state
    val abort2 = RegInit(0.U(UInt(1.W)))
    switch(state) {
        is(State.RX_RESET) {
            when(io.reset.asBool === 0.U) {
                state := State.RX_WAIT
            } .otherwise {
                io.rx_active := 0.U
                io.rx_valid := 0.U
            }
        }
        is(State.RX_WAIT) {
            when(SYNC_EOP_LS.io.sop === 1.U) {  // have to detect sync pattern
                // sync starts when it goes from idle state to K state 
                io.rx_active := 1.U
                state := State.STRIP_SYNC
            } .otherwise {
                state := State.RX_WAIT
            }
        }
        is(State.STRIP_SYNC) { 
            when(SYNC_EOP_LS.io.sync === 1.U) {        
                state := State.RX_DATA
            }.otherwise {
                state := State.STRIP_SYNC
            }
        }
        is(State.RX_DATA) {
            when(io.serial_ready === 1.U) {
                io.rx_active := 0.U
                io.rx_valid := 0.U
                state := State.STRIP_EOP
            }.elsewhen ((io.bitunstufferror | io.error) === 1.U) {
                io.rx_error := 1.U
                when (io.bitunstufferror === 1.U) {
                    abort2 := 1.U
                } .otherwise {
                    abort2 := 0.U
                }
                io.rx_valid := 1.U
                state := State.ERROR
            }.otherwise {
                io.rx_valid := 0.U
                state := State.RX_DATA
            }
        }
        is(State.STRIP_EOP) {
            // io.rx_active := 0.U
            // io.rx_valid := 0.U
            when(SYNC_EOP_LS.io.eop === 1.U) {  
                state := State.RX_WAIT
            }.otherwise {
                state := State.STRIP_EOP
            }
        }
        is(State.ERROR) {
            // io.rx_error := 1.U
            when(abort2 =/= 1.U) {
                state := State.ABORT1
            }.otherwise{
                state := State.ABORT2
            }
        }
        is(State.ABORT1) {
            state := State.RX_WAIT
            io.rx_valid := 0.U
            io.rx_error := 0.U
            io.rx_active := 0.U
        }
        is(State.ABORT2) {
            io.rx_error := 0.U
            io.rx_valid := 0.U
            when(((SYNC_EOP_LS.io.j === 1.U) && (io.hs_toggle === 0.U)) | ((SYNC_EOP_LS.io.se0 === 1.U) && (io.hs_toggle === 1.U))) {
                state := State.TERMINATE
            }
        }
        is(State.TERMINATE) {
            io.rx_active := 0.U
            state := State.RX_WAIT
        }
    }
}

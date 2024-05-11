package usb2

// Standard imports
import chisel3._
import java.io.Serial
import chisel3.util._

/* 
 * RX Top Level
 *  
 * This Rx Module takes in a differential serial data pair (D+ and D-) from PHY 
 * and outputs handshake, linestate, and output dataWidth data to UTMI. 
 * A fuller implementation would coordinate with the PHY, clock and data recovery
 * teams to ensure linestate functionality based off analog voltage levels 
 * and differentiation between PHY and data recovery HS/FS data, currently
 * abstracted as cru_hs_toggle.
 */

class USB_RX(dataWidth: Int) extends Module {
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
        val clk = Input(Clock()); // 480 MHz ? ? ?
        //val squelch = Input(UInt(1.W)); // Squelch for linestate HS mode
        val cru_hs_toggle = Input(UInt(1.W)); // XcvrSelect = 0
    })

    /* Differential Handling */
    io.utmi_dataout := 0.U
    io.utmi_rx_valid := false.B
    io.utmi_rx_active := false.B
    io.utmi_rx_error := false.B
    io.utmi_linestate := 0.U // todo

}


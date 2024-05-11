package usb2

import chisel3._
import chisel3.util._

/* 
 * Linestate segment of state machine.
 * 
 * Within the state machine, we have a module called SYNC_EOP_LS that
 * will handle all of the SOP, SYNC, EOP detection. It will also handle 
 * the line state signals that will be send to the UTMI. Based on whether 
 * is it high speed or full speed, it will handle the detections and stripping accordingly. 
 * 
 */

/* 
SYNC STRIP 
LS/FS = KJKJKJKK
HS    = KJ * 15 + KK,
EOP STRIP, 
Linestate handler,
Start of Packet (SOP) indicator
*/

class SYNC_EOP_LS extends Module {
    val io = IO(new Bundle {
        val data_d_plus = Input(UInt(1.W))  // D+
        val data_d_minus = Input(UInt(1.W)) // D-
        val hs_toggle = Input(UInt(1.W))    // High if HS 
        val linestate = Output(UInt(2.W))   // Linestate
        val sop = Output(UInt(1.W))         // Start of Packet 
        val se0 = Output(UInt(1.W))         // SE0
        val se1 = Output(UInt(1.W))         // SE1
        val j = Output(UInt(1.W))           // J
        val k = Output(UInt(1.W))           // K
        val sync = Output(UInt(1.W))        // High if SYNC pattern detected
        val eop = Output(UInt(1.W))         // High if EOP pattern detected 
    })

    // Linestate Handler 
    val prev_linestate = RegInit(0.U(2.W)) 
    prev_linestate := io.linestate
    // SOP happens when you go from IDLE state to K state 
    // How long should it be in this state to be considered IDLE? 
    // Right now the code assumes IDLE -> K transistion is SOP 
    // FS IDLE state = J 
    // HS IDLE state = SE0
    io.sop := (prev_linestate === 1.U && io.linestate === 2.U)
    // Line state 
    // HS -> K and SE1 are invalid states
    when (io.data_d_plus === 0.U && io.data_d_minus === 0.U) {
        io.se0 := 1.U
        io.se1 := 0.U
        io.j := 0.U
        io.k := 0.U
        io.linestate := 0.U
    } .elsewhen(io.data_d_plus === 1.U && io.data_d_minus === 1.U) {
        io.se0 := 0.U
        io.se1 := 1.U
        io.j := 0.U
        io.k := 0.U
        io.linestate := 3.U
    } .elsewhen(io.data_d_plus === 1.U && io.data_d_minus === 0.U) {
        io.linestate := 1.U
        io.se0 := 0.U
        io.se1 := 0.U
        io.j := 1.U
        io.k := 0.U
    } .otherwise {
        io.se0 := 0.U
        io.se1 := 0.U
        io.j := 0.U
        io.k := 1.U
        io.linestate := 2.U
    } 

    // SYNC and EOP Handler 
    val pattern_fs = RegInit(0.U(8.W))      // KJKJKJKK
    val pattern_hs = RegInit(0.U(32.W))     // KJ * 15 + KK
    val pattern_eop_fs = RegInit(0.U(3.W))  // {SE0, SE0, J}
    val pattern_eop_hs = RegInit(0.U(8.W))  // K * 8 || J * 8

    io.eop := Mux(io.hs_toggle === 1.U, (pattern_eop_hs === "hFF".U), (pattern_eop_fs === "h7".U))
    io.sync := Mux(io.hs_toggle === 1.U, (pattern_hs === "h55555554".U), (pattern_fs === "h54".U))
    when (io.hs_toggle === 1.U) {
        pattern_hs := Cat(pattern_hs(30, 0), io.j)
        pattern_eop_hs := Cat(pattern_eop_hs(6, 0), io.j | io.k)
    } .otherwise {
        pattern_fs := Cat(pattern_fs(6, 0), io.j)
        pattern_eop_fs := Cat(pattern_eop_fs(1, 0), (io.se0 & (pattern_eop_fs =/= 6.U)) | (io.j & (pattern_eop_fs === 6.U)))
    }
}

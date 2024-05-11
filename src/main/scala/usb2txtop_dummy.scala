// package usb2

// import chisel3._
// import chisel3.util._

// class USBTx(dWidth: Int) extends Module {
//   /**  Explicit parameterization might not be needed
//     *  Otherwise can use dWidth/2 (with requrire(dWidth % 2 == 0))
//     */
//   val io = IO(new Bundle {
//     val pDin_packet = Flipped(Decoupled(UInt(dWidth.W))) // validH is incorporated in pDin_packet.valid 

//     val serialClk   = Input(Clock())      // From PLL, external clock is assumed to be in phase
//     val xcvrSel     = Input(UInt(1.W))    // 0: HS (480 MHz), 1: FS (12 MHz)
//     val valid       = Output(UInt(1.W))   // Pull-up is low when actively communicating, not sure if valid need to be exposed
//     val opMode      = Input(UInt(2.W))    // Highest priority. 
//                                           // 00: Normal, 
//                                           // 01: Non-driving (propagate to Tx Driver => remove termination)
//                                           // 10: BitStuffing and NRZI disabled
//     val sofDetectSIE = Input(UInt(1.W))   // Start of Frame detection from SIE
//     val fsDout       = Output(UInt(1.W))   
//     val seo          = Output(UInt(1.W))
//     val oe           = Output(UInt(1.W))

//     val rpuEn        = Output(UInt(1.W))    // Pull-up resistor enable: Asserted when the device is ready

//     val hsDout       = Output(UInt(1.W))
//     val hsDriveEn    = Output(UInt(1.W))
//     val hsCurrEn     = Output(Bool())

//     val tx_busy = Output(Bool()) //todo: add back @ TX
//   })

//   io.pDin_packet.ready := true.B // ready valid handshake
//   io.tx_busy := false.B
//   io.fsDout    := 0.U
//   io.seo       := 0.U
//   io.oe        := 0.U
//   io.rpuEn     := 0.U
//   io.hsDout    := 0.U
//   io.hsDriveEn := 0.U
//   io.hsCurrEn  := false.B
//   io.valid := false.B
// }
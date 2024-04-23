package usb2

import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.tilelink._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.subsystem._


import chisel3.experimental.{IntParam, BaseModule}
import freechips.rocketchip.prci._
import freechips.rocketchip.util.UIntIsOneOf


// TODO confirm
// I think we should do UTMI over mmio but have explicit ios for the differential output

// IO Declarations
class Usb2TopIO extends Bundle {
  val DP = Analog(1.W) // Analog type (equivalent to Verilog inout)
  val DM = Analog(1.W)
}

case class Usb2Params(
	// config params
  // TODO: use real params, these are just for the loopback
	address: BigInt = 0x7000,
  depth: Int = 32, 
  width: Int = 8,
)

class UTMI(params: Usb2Params, beatBytes: Int)
  extends Module {
    val io = IO(new Bundle {
    // UTMI Controls
    val utmi_xcvr_select = Input(UInt(1.W))  // Transceiver Select
    val utmi_term_select = Input(UInt(1.W))  // Termination Select
    val utmi_suspend_n   = Input(UInt(1.W))  // Active-Low Suspend 
    val utmi_line_state  = Output(UInt(2.W)) // Received Line State
    val utmi_opmode      = Input(UInt(2.W))  // Operation Mode

    // UTMI TX 
    val utmi_datain      = Input(UInt(params.width.W)) // TX Data Input
    val utmi_tx_valid    = Input(Bool())               // TX Valid 
    val utmi_tx_ready    = Output(Bool())              // TX Ready

    // UTMI RX 
    val utmi_dataout     = Output(UInt(params.width.W)) // RX Data Output
    val utmi_rx_valid    = Output(Bool())               // RX Valid
    val utmi_rx_active   = Output(Bool())               // RX Active
    val utmi_rx_error    = Output(Bool())               // RX Error

    // %%% Do we need to specify a clock and a reset for our block?
    val clock = Input(Clock()) // %%% Clock()? The 480MHz clk
    val reset = Input(Bool())
    val utmi_clk = Output(UInt(1.W)) // %%% UInt(1.W)? The 30/60MHz clk
  })

  // %%% RX + TX here (Or put RX, TX in Usb2Top?) Also, where should we put the async FIFO?
  val Usb2RxTop = Module(new Usb2RxTop(params.width.W))
  Usb2RxTop.io.utmi_datain // %%% To Rx team: This should be a single bit data. Where can we get this data, from DP/DM? 
  // %%% If we need DP/DM, should we just write this UTMI module inside Usb2Top?
  Usb2RxTop.io.utmi_clk   := io.utmi_clk
  Usb2RxTop.io.utmi_reset := io.reset
  io.utmi_dataout         := Usb2RxTop.io.utmi_dataout
  io.utmi_rx_valid        := Usb2RxTop.io.utmi_rx_valid
  io.utmi_rx_active       := Usb2RxTop.io.utmi_rx_active
  io.utmi_rx_error        := Usb2RxTop.io.utmi_rx_error
  // %%% How should we handle these signals?
  Usb2RxTop.io.cru_fs_vp     := io.cru_fs_vp    
  Usb2RxTop.io.cru_fs_vm     := io.cru_fs_vm    
  Usb2RxTop.io.cru_hs_vp     := io.cru_hs_vp    
  Usb2RxTop.io.cru_hs_vm     := io.cru_hs_vm    
  Usb2RxTop.io.cru_hs_toggle := io.cru_hs_toggle
  Usb2RxTop.io.cru_clk       := io.cru_clk      

  val Usb2TxTop = Module(new USBTx(params.width.W))
  Usb2TxTop.io.in.bits  := io.utmi_datain
  Usb2TxTop.io.in.valid := io.utmi_tx_valid
  io.utmi_tx_ready      := Usb2TxTop.io.in.ready
  // %%% How should we handle these signals?
  io.rpuEn     := Usb2TxTop.io.rpuEn    
  io.vpo       := Usb2TxTop.io.vpo      
  io.oeb       := Usb2TxTop.io.oeb      
  io.hsData    := Usb2TxTop.io.hsData   
  io.hsDriveEn := Usb2TxTop.io.hsDriveEn
  io.hsCsEn    := Usb2TxTop.io.hsCsEn   

}

class Usb2Top(params: Usb2Params, beatBytes: Int)(implicit p: Parameters) extends ClockSinkDomain(ClockSinkParameters())(p) {

  val io: Usb2TopIO
  val clock: Clock
  val reset: Reset

  // Allow restart of UTMI at any point.
  ex.ready := true.B
  // Hold reset for at least one full cycle after EX register written.
  val pastValid = RegInit(false.B)
  pastValid := ex.valid
  utmiReset := false.B
  when (ex.valid || pastValid) {
    utmiReset := true.B
  }

  val utmi = withReset(utmiReset) {
    Module(new UTMI(params, beatBytes))
  }

    val mmio_device = new SimpleDevice("LoopBack", Seq("eecs251b,usb2")) 
    val mmio_node = TLRegisterNode(Seq(AddressSet(params.address, 4096-1)), mmio_device, "reg/control", beatBytes=beatBytes)


    override lazy val module = new Usb2ModuleImp()

    class Usb2ModuleImp extends Impl {
        val io = IO(new Usb2TopIO)
        
        // Instantiate TileLink communication module
        withClockAndReset(clock, reset) {

           val data_buffer = Module(new Queue(UInt(params.width.W), params.depth))

           mmio_node.regmap(
              0x00 -> Seq(
                RegField.w(params.width, data_buffer.io.enq)),
              0x04 -> Seq(
                RegField.r(params.width, data_buffer.io.deq)))
            
        }

    }
}


case object Usb2Key extends Field[Option[Usb2Params]](None)

trait CanHavePeripheryUsb2 { this: BaseSubsystem =>
  private val portName = "usb2-utmi"

      implicit val p: Parameters
    p(Usb2Key) .map { params =>
        val usb2 = LazyModule(new Usb2Top(params, pbus.beatBytes)(p))

        usb2.clockNode := pbus.fixedClockNode
        pbus.coupleTo(portName) { usb2.mmio_node := TLFragmenter(pbus.beatBytes, pbus.blockBytes) := _ } 
    }

}

trait CanHavePeripheryUsbImp extends LazyModuleImp {
  val outer: CanHavePeripheryUsb2
}



// TODO: what other params should be passed?
class WithUsb2(params: Usb2Params) extends Config((site, here, up) => {
  case Usb2Key => Some(params)
})

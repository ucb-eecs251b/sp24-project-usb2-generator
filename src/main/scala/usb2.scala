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

  // PLL clock (Type?)
  val utmi_clk = Analog(1.W)
  val clk_480  = Analog(1.W)

  // RxLogic input signals (Type?)
  val cru_fs_vp     = Analog(1.W)
  val cru_fs_vm     = Analog(1.W)
  val cru_hs_vp     = Analog(1.W)
  val cru_hs_vm     = Analog(1.W)
  val cru_hs_toggle = Analog(1.W)
  val cru_clk       = Analog(1.W)

  // TxLogic output signals (Type?)
  val rpuEn     = Analog(1.W)
  val vpo       = Analog(1.W)
  val oeb       = Analog(1.W)
  val hsData    = Analog(1.W)
  val hsDriveEn = Analog(1.W)
  val hsCsEn    = Analog(1.W)
}

case class Usb2Params(
	// config params
  // TODO: use real params, these are just for the loopback
	address: BigInt = 0x7000,
  depth: Int = 32, 
  width: Int = 8,
  asyncQueueSz: Int = 8 // May change this? Is 1 enough?
)

class Usb2Top(params: Usb2Params, beatBytes: Int)(implicit p: Parameters) extends ClockSinkDomain(ClockSinkParameters())(p) {

  val io: Usb2TopIO
  val clock: Clock // This is 500MHz?
  val reset: Reset

  // RX
  val usb2RxLogic = Module(new Usb2RxTop(params.width.W))
  // usb2RxLogic.io.utmi_datain
  usb2RxLogic.io.utmi_clk   := io.utmi_clk
  usb2RxLogic.io.utmi_reset := reset
  // RxLogic input from TopIO
  usb2RxLogic.io.cru_fs_vp     := io.cru_fs_vp    
  usb2RxLogic.io.cru_fs_vm     := io.cru_fs_vm    
  usb2RxLogic.io.cru_hs_vp     := io.cru_hs_vp    
  usb2RxLogic.io.cru_hs_vm     := io.cru_hs_vm    
  usb2RxLogic.io.cru_hs_toggle := io.cru_hs_toggle
  usb2RxLogic.io.cru_clk       := io.cru_clk    

  // Async FIFO for CDC between 480MHz and 30/60MHz, located between SIE and RX hold register. Assuming the RX Logic is clocked "entirely" against 480MHz.
  // Currently the RX FSM seems to be clocked against 30/60MHz.
  val rx_async = Module(new AsyncQueue(UInt(params.width.W), AsyncQueueParams(depth=params.asyncQueueSz)))
  rx_async.io.enq_clock := io.cru_clk // 480MHz
  rx_async.io.enq_reset := reset
  rx_async.io.deq_clock := io.utmi_clk // 30/60MHz
  rx_async.io.deq_reset := false.B 
  rx_async.io.enq.bits  := usb2RxLogic.io.utmi_dataout
  rx_async.io.enq.valid := usb2RxLogic.io.utmi_rx_valid
  // rx_async.io.enq.ready
  rx_async.io.deq.ready := true.B  


  withClockAndReset(clk_480, reset) { // Reset?
    val usb2TxLogic = Module(new USBTx(params.width.W))
  }
  val utmi_datain = RegInit(0.U(params.width.W))
  usb2TxLogic.io.in.bits  := utmi_datain
  val utmi_tx_valid = RegInit(false.B)
  usb2TxLogic.io.in.valid := utmi_tx_valid
  // TxLogic output to TopIO
  io.rpuEn     := usb2TxLogic.io.rpuEn    
  io.vpo       := usb2TxLogic.io.vpo      
  io.oeb       := usb2TxLogic.io.oeb      
  io.hsData    := usb2TxLogic.io.hsData   
  io.hsDriveEn := usb2TxLogic.io.hsDriveEn
  io.hsCsEn    := usb2TxLogic.io.hsCsEn   

    val mmio_device = new SimpleDevice("LoopBack", Seq("eecs251b,usb2")) 
    val mmio_node = TLRegisterNode(Seq(AddressSet(params.address, 4096-1)), mmio_device, "reg/control", beatBytes=beatBytes)


    override lazy val module = new Usb2ModuleImp()

    class Usb2ModuleImp extends Impl {
        val io = IO(new Usb2TopIO)
        
        // Instantiate TileLink communication module
        withClockAndReset(clock, reset) {

           val data_buffer = Module(new Queue(UInt(params.width.W), params.depth)) // Question: What is this used for?

           mmio_node.regmap( // Question: MMIO takes multiple cycles, need to write FSM to control?
              0x00 -> Seq(
                RegField.w(params.width, data_buffer.io.enq)),
              0x04 -> Seq(
                RegField.r(params.width, data_buffer.io.deq)),
              0x08 -> Seq(
                RegField.r(params.width, rx_async.io.deq.bits)),
              0x0C -> Seq(
                RegField.r(1, rx_async.io.deq.valid)), // Question: This is coming from slower clock domain, will asserting too many times cause problem?
              0x10 -> Seq(
                RegField.r(1, usb2RxLogic.io.utmi_rx_active)), // Question: Will async FIFO cause us not accurately reflecting active?
              0x14 -> Seq(
                RegField.r(1, usb2RxLogic.io.utmi_rx_error)), // Question: Will async FIFO cause us not accurately reflecting error?
              0x18 -> Seq(
                RegField.w(params.width, utmi_datain)),
              0x1C -> Seq(
                RegField.w(1, utmi_tx_valid)),
              0x20 -> Seq(
                RegField.r(1, usb2TxLogic.io.in.ready))
           )
            
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

package usb2

import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.tilelink._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.subsystem._
//import chisel3.experimental._ // Analog
import chisel3.experimental.{Analog, IntParam, BaseModule}
import freechips.rocketchip.prci._
import freechips.rocketchip.util.UIntIsOneOf
import freechips.rocketchip.util._

// TODO confirm
// I think we should do UTMI over mmio but have explicit ios for the differential output

// IO Declarations
class Usb2TopIO extends Bundle {
  // clock & reset
  val reset = Input(Bool())
  val clock = Input(Clock())

  val DP = Analog(1.W) // Analog type (equivalent to Verilog inout)
  val DM = Analog(1.W)

  // PLL clock (Type?)
  val utmi_clk = Analog(1.W) // 30/60MHz
  val clk_480  = Clock()

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

  val clock: Clock // TL clock (500 or 200 MHz)
  val reset: Reset
  
  val io = IO(new Usb2TopIO) 
  
  // RX
  val usb2RxLogic = Module(new Usb2RxTop(params.width)) 
  usb2RxLogic.io.utmi_clk   := io.utmi_clk
  usb2RxLogic.io.utmi_reset := reset

  // RX data bundle
  val rx_bundle = Wire(new DecoupledIO(UInt((params.width + 2).W))) // [RXError, RXActive, RXDataOut]
  // AsyncFIFO from 30/60MHz to TL clock domain
  val rx_async = Module(new AsyncQueue(UInt(params.width.W), AsyncQueueParams(depth=params.asyncQueueSz)))
  rx_async.io.enq_clock := io.utmi_clk // 30/60MHz
  rx_async.io.enq_reset := reset
  rx_async.io.deq_clock := clock // TL clock
  rx_async.io.deq_reset := false.B 
  rx_async.io.enq.bits  := Cat(Cat(usb2RxLogic.io.utmi_rx_error, usb2RxLogic.io.utmi_rx_active), usb2RxLogic.io.utmi_dataout)
  rx_async.io.enq.valid := usb2RxLogic.io.utmi_rx_valid
  // rx_async.io.enq.ready
  rx_async.io.deq.ready := rx_bundle.ready
  rx_bundle.bits        := rx_async.io.deq.bits
  rx_bundle.valid       := rx_async.io.deq.valid 

  // RxLogic input from TopIO
  usb2RxLogic.io.cru_fs_vp     := io.cru_fs_vp    
  usb2RxLogic.io.cru_fs_vm     := io.cru_fs_vm    
  usb2RxLogic.io.cru_hs_vp     := io.cru_hs_vp    
  usb2RxLogic.io.cru_hs_vm     := io.cru_hs_vm    
  usb2RxLogic.io.cru_hs_toggle := io.cru_hs_toggle
  usb2RxLogic.io.cru_clk       := io.cru_clk    

  // TX
  //withClockAndReset(io.clk_480, reset) { // Reset?
  val usb2TxLogic = Module(new USBTx(params.width))
  //}
  // MMIO tx_datain
  val utmi_datain = Flipped(DecoupledIO(UInt(params.width.W)))

  // AsyncFIFO from TL clock domain to 30/60MHz
  val tx_async = Module(new AsyncQueue(UInt(params.width.W), AsyncQueueParams(depth=params.asyncQueueSz)))
  tx_async.io.enq_clock   := clock // TL clock
  tx_async.io.enq_reset   := reset
  tx_async.io.deq_clock   := io.utmi_clk // 30/60MHz
  tx_async.io.deq_reset   := false.B 
  tx_async.io.enq.bits    := utmi_datain.bits
  tx_async.io.enq.valid   := utmi_datain.valid
  utmi_datain.ready       := tx_async.io.enq.ready
  tx_async.io.deq.ready   := usb2TxLogic.io.in.ready
  usb2TxLogic.io.in.bits  := tx_async.io.deq.bits
  usb2TxLogic.io.in.valid := tx_async.io.deq.valid

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
                RegField.r(params.width+2, rx_bundle)),
              0x18 -> Seq(
                RegField.w(params.width, utmi_datain)),
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

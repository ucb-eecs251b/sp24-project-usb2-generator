package usb2

import chisel3._
import chisel3.util._
import chisel3.experimental.{Analog, IntParam, BaseModule}
import freechips.rocketchip.prci._
import freechips.rocketchip.subsystem.{BaseSubsystem} 
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.regmapper.{HasRegMap, RegField}
import freechips.rocketchip.tilelink._
import freechips.rocketchip.util.{UIntIsOneOf, AsyncQueue, AsyncQueueParams}

case class Usb2Params(
	// config params
  // TODO: use real params, these are just for the loopback
    address: BigInt = 0x7000,
    depth: Int = 32, 
    width: Int = 8,
    asyncQueueSz: Int = 8, // May change this? Is 1 enough?
    loopback: Boolean = false // for integration test only
)

case object Usb2Key extends Field[Option[Usb2Params]](None)

class Usb2IO(params: Usb2Params) extends Bundle {
  // clock & reset
  val reset = Input(Bool())
  // val clock = Input(Clock())

  val DP = Analog(1.W) // Analog type (equivalent to Verilog inout)
  val DM = Analog(1.W)

  // PLL clock (Type?)
  // val utmi_clk = Input(Clock()) // 30/60MHz
  // val clk_480  = Clock()

  // RxLogic input signals 
  val cru_hs_toggle = Input(UInt(1.W))
  val utmi_linestate = Output(UInt(2.W)) 
  val data_d_plus = Input(UInt(1.W)) 
  val data_d_minus = Input(UInt(1.W))  
  // val cru_clk       = Input(Clock())

  // TxLogic input signals
  val xcvrSel     = Input(UInt(1.W))
  val opMode      = Input(UInt(2.W))
  val sofDetectSIE = Input(UInt(1.W)) // to TX

  // TxLogic output signals (Type? - analog)

  val fsDout       = Output(UInt(1.W))  // new
  val seo          = Output(UInt(1.W))  // new
  val oe           = Output(UInt(1.W))  // oeb
  val rpuEn        = Output(UInt(1.W)) 
  val hsDout       = Output(UInt(1.W))  // hsData
  val hsDriveEn    = Output(UInt(1.W))
  val hsCurrEn     = Output(Bool())     // hsCsEn

  // chisel test
  val asyncQ_tx_data = Output(UInt(params.width.W))

  // MMIO
  val busy = Output(Bool())

  val mmio_tx_data = Input(UInt(params.width.W))
  val mmio_tx_ready = Output(Bool())
  val mmio_tx_valid = Input(Bool())

  val mmio_rx_data = Output(UInt((params.width + 2).W))
  val mmio_rx_ready = Input(Bool())
  val mmio_rx_valid = Output(Bool())

}

class Usb2TopIO extends Bundle {
  val tx_busy = Output(Bool())
}

trait HasUsb2TopIO {
  def io: Usb2TopIO
}

class Usb2Top(params: Usb2Params) extends Module { // Usb2MMIOChiselModule - not MMIO
  val io = IO(new Usb2IO(params))
  // RX
  val usb2RxLogic = Module(new USB_RX(params.width)) 

  // RxLogic input from TopIO
  usb2RxLogic.io.cru_hs_toggle := io.cru_hs_toggle
  usb2RxLogic.io.clk   := clock // io.cru_clk  (60MHz)
  // usb2RxLogic.io.reset := reset
  usb2RxLogic.io.data_d_plus := io.data_d_plus
  usb2RxLogic.io.data_d_minus := io.data_d_minus
  io.utmi_linestate := usb2RxLogic.io.utmi_linestate

  // AsyncFIFO from 30/60MHz to TL clock domain
  val rx_async = Module(new AsyncQueue(UInt((params.width + 2).W), AsyncQueueParams(depth=params.asyncQueueSz)))
  rx_async.io.enq_clock := clock // io.cru_clk // 30/60MHz
  rx_async.io.enq_reset := reset
  rx_async.io.deq_clock := clock // TL clock
  rx_async.io.deq_reset := false.B 
  rx_async.io.enq.bits  := Cat(Cat(usb2RxLogic.io.utmi_rx_error, usb2RxLogic.io.utmi_rx_active), usb2RxLogic.io.utmi_dataout)
  rx_async.io.enq.valid := usb2RxLogic.io.utmi_rx_valid
  // rx_async.io.enq.ready
  rx_async.io.deq.ready := io.mmio_rx_ready
//   rx_bundle <> rx_async.io.deq
  io.mmio_rx_data       := rx_async.io.deq.bits
  io.mmio_rx_valid      := rx_async.io.deq.valid 

  // TX
  val usb2TxLogic = Module(new USBTx(params.width))

  // AsyncFIFO from TL clock domain to 30/60MHz
  val tx_async = Module(new AsyncQueue(UInt(params.width.W), AsyncQueueParams(depth=params.asyncQueueSz)))
  tx_async.io.enq_clock   := clock // TL clock
  tx_async.io.enq_reset   := reset
  tx_async.io.deq_clock   := clock // io.utmi_clk // 30/60MHz
  tx_async.io.deq_reset   := false.B 
  tx_async.io.enq.bits    := io.mmio_tx_data
  tx_async.io.enq.valid   := io.mmio_tx_valid
  io.mmio_tx_ready        := tx_async.io.enq.ready
  io.asyncQ_tx_data := tx_async.io.deq.bits 

  //tx_async.io.deq.ready   := usb2TxLogic.io.pDin_packet.ready 
  //usb2TxLogic.io.pDin_packet.bits  := tx_async.io.deq.bits
  //usb2TxLogic.io.pDin_packet.valid := tx_async.io.deq.valid
  usb2TxLogic.io.pDin_packet <> tx_async.io.deq
  usb2TxLogic.io.serialClk := clock // utmi_clk
  usb2TxLogic.io.xcvrSel := io.xcvrSel
  usb2TxLogic.io.opMode := io.opMode
  usb2TxLogic.io.sofDetectSIE := io.sofDetectSIE
  // exclude usb2TxLogic.io.valid

  // TxLogic output to TopIO
  io.fsDout       := usb2TxLogic.io.fsDout     // new
  io.seo          := usb2TxLogic.io.seo        // new
  io.oe           := usb2TxLogic.io.oe         // oeb
  io.rpuEn        := usb2TxLogic.io.rpuEn     
  io.hsDout       := usb2TxLogic.io.hsDout     // hsData
  io.hsDriveEn    := usb2TxLogic.io.hsDriveEn
  io.hsCurrEn     := usb2TxLogic.io.hsCurrEn   // hsCsEn 

  io.busy := ~(tx_async.io.enq.ready)

}
// DOC include end: usb2 chisel

// DOC include start: usb2 router

/* 
 * USB2.0 TileLink
 * The USB 2.0 generator is set up as a tilelink node with a basic 'loopback' functionality. 
 * */

class Usb2TL(params: Usb2Params, beatBytes: Int)(implicit p: Parameters) extends ClockSinkDomain(ClockSinkParameters())(p) {
  /* 
   * While you can directly specify a manager node and write all of the logic to handle TileLink requests, 
   * it is usually much easier to use a register node. This type of node provides a regmap method that 
   * allows you to specify control/status registers and automatically generates the logic to handle the TileLink protocol. 
   * .. Below is the Register Node specification.
   */
  val mmio_device = new SimpleDevice("LoopBack", Seq("eecs251b,usb2")) 
  val mmio_node = TLRegisterNode(Seq(AddressSet(params.address, 4096-1)), mmio_device, "reg/control", beatBytes=beatBytes)

  override lazy val module = new Usb2Impl

  /* 
   * To create a RegisterRouter-based peripheral, you will need to specify a parameter case class for the configuration settings, 
   * a bundle trait with the extra top-level ports, and a module implementation containing the actual RTL.
   * ...Below is the actual RTL, I think. 
   */
  class Usb2Impl extends Impl with HasUsb2TopIO {
    val io = IO(new Usb2TopIO)
    withClockAndReset(clock, reset) { // implicit clock from LazyModule
      val data_buffer = Module(new Queue(UInt(params.width.W), params.depth)) // Question: What is this used for?

      // How many clock cycles in a PWM cycle?
      val rx_bundle = Wire(new DecoupledIO(UInt((params.width + 2).W))) // [RXError, RXActive, RXDataOut]
      val utmi_datain = Wire(Flipped(DecoupledIO(UInt(params.width.W))))

      val impl = Module(new Usb2Top(params))

      // impl.io.clock := clock
      impl.io.reset := reset.asBool

      // impl.io.asyncQ_tx_data := "d0".asUInt(8.W)
      impl.io.mmio_tx_data  := utmi_datain.bits // need to add impl ports
      impl.io.mmio_tx_valid := utmi_datain.valid
      utmi_datain.ready     := impl.io.mmio_tx_ready

      impl.io.mmio_rx_ready := rx_bundle.ready
      rx_bundle.bits        := impl.io.mmio_rx_data
      rx_bundle.valid       := impl.io.mmio_rx_valid

      io.tx_busy := impl.io.busy

      // 200MHz simulation clock
      // Divide by 33 -> 60MHz TX clock
      // Divide by 33 -> 60MHz RX clock
      impl.io.cru_hs_toggle  := 0.U
      impl.io.data_d_plus := 0.U
      impl.io.data_d_minus := 0.U

      impl.io.xcvrSel := 0.U
      impl.io.opMode := 0.U
      impl.io.sofDetectSIE := 0.U

      // 200 -> 60
      // impl.io.cru_clk := clock
      // impl.io.utmi_clk := clock

      /* 
      * While you can directly specify a manager node and write all of the logic to handle TileLink requests, 
      * it is usually much easier to use a register node. This type of node provides a regmap method that 
      * allows you to specify control/status registers and automatically generates the logic to handle the TileLink protocol. 
      * .. Below is the regmap for above register node.
      */

      mmio_node.regmap( // Question: MMIO takes multiple cycles, need to write FSM to control?
              0x00 -> Seq(
                RegField.w(params.width, data_buffer.io.enq)),
              0x04 -> Seq(
                RegField.r(params.width, data_buffer.io.deq)),
              0x08 -> Seq(
                RegField.r(params.width+2, rx_bundle)),
              0x18 -> Seq(
                RegField.w(params.width, utmi_datain))
            )
    }
  }
}

/* 
 * To create a RegisterRouter-based peripheral, you will need to specify a parameter case class for the configuration settings, 
 * a bundle trait with the extra top-level ports, and a module implementation containing the actual RTL.
 * ...Below is the trait with extra top-level ports, I think. 
 */

trait CanHavePeripheryUsb2 { this: BaseSubsystem =>
  private val portName = "usb2"

  // private val pbus = locateTLBusWrapper(PBUS)

  // Only build if we are using the TL (nonAXI4) version
  val tx_busy = p(Usb2Key) match {
    case Some(params) => {
      val usb2 = LazyModule(new Usb2TL(params, pbus.beatBytes)(p)) 
      usb2.clockNode := pbus.fixedClockNode
      pbus.coupleTo(portName) { usb2.mmio_node := TLFragmenter(pbus.beatBytes, pbus.blockBytes) := _ }
        
      val tx_busy = InModuleBody {
        val busy = IO(Output(Bool())).suggestName("tx_busy")
        busy := usb2.module.io.tx_busy
        busy
      }
      Some(tx_busy)
    }
    case None => None
  }
}

/* These are parameters to be passed through the config mixin, I think. */

// TODO: what other params should be passed?
class WithUsb2(params: Usb2Params) extends Config((site, here, up) => {
  case Usb2Key => Some(params)
})
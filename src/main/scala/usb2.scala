package usb2

import chisel3._
import chisel3.util._
import chisel3.experimental.{Analog, IntParam, BaseModule}
import freechips.rocketchip.prci._
import freechips.rocketchip.subsystem.{BaseSubsystem, PBUS} // delete pbus?
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

  // RxLogic input signals (Type?)
  val cru_fs_vp     = Input(SInt(1.W))
  val cru_fs_vm     = Input(SInt(1.W))
  val cru_hs_vp     = Input(SInt(1.W))
  val cru_hs_vm     = Input(SInt(1.W))
  val cru_hs_toggle = Input(UInt(1.W))
  // val cru_clk       = Input(Clock())

  // TxLogic output signals (Type? - analog)
  val rpuEn     = Output(UInt(1.W))
  val vpo       = Output(UInt(1.W))
  val oeb       = Output(UInt(1.W))
  val hsData    = Output(UInt(1.W))
  val hsDriveEn = Output(UInt(1.W))
  val hsCsEn    = Output(UInt(1.W))

  // chisel test
  val asyncQ_tx_data = Output(UInt(params.width.W))

  // val why = Input(Bool())

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
  val usb2RxLogic = Module(new Usb2RxTop(params.width)) 
  usb2RxLogic.io.utmi_clk   := clock // io.utmi_clk
  usb2RxLogic.io.utmi_reset := reset

  // AsyncFIFO from 30/60MHz to TL clock domain
  val rx_async = Module(new AsyncQueue(UInt((params.width + 2).W), AsyncQueueParams(depth=params.asyncQueueSz)))
  rx_async.io.enq_clock := clock // io.utmi_clk // 30/60MHz
  rx_async.io.enq_reset := reset
  rx_async.io.deq_clock := clock // TL clock [vs io.clk?]
  rx_async.io.deq_reset := false.B 
  rx_async.io.enq.bits  := Cat(Cat(usb2RxLogic.io.utmi_rx_error, usb2RxLogic.io.utmi_rx_active), usb2RxLogic.io.utmi_dataout)
  rx_async.io.enq.valid := usb2RxLogic.io.utmi_rx_valid
  // rx_async.io.enq.ready
  rx_async.io.deq.ready := io.mmio_rx_ready
//   rx_bundle <> rx_async.io.deq
  io.mmio_rx_data       := rx_async.io.deq.bits
  io.mmio_rx_valid      := rx_async.io.deq.valid 

  // RxLogic input from TopIO
  usb2RxLogic.io.cru_fs_vp     := io.cru_fs_vp    
  usb2RxLogic.io.cru_fs_vm     := io.cru_fs_vm    
  usb2RxLogic.io.cru_hs_vp     := io.cru_hs_vp    
  usb2RxLogic.io.cru_hs_vm     := io.cru_hs_vm    
  usb2RxLogic.io.cru_hs_toggle := io.cru_hs_toggle
  usb2RxLogic.io.cru_clk       := clock // io.cru_clk    

  // TX
  //withClockAndReset(io.clk_480, reset) { // Reset?
  val usb2TxLogic = Module(new USBTx(params.width))
  //}

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
  // io.asyncQ_tx_data := "hc".U(8.W)

  //tx_async.io.deq.ready   := usb2TxLogic.io.in.ready
  //usb2TxLogic.io.in.bits  := tx_async.io.deq.bits
  //usb2TxLogic.io.in.valid := tx_async.io.deq.valid
  usb2TxLogic.io.in <> tx_async.io.deq


  // TxLogic output to TopIO
  io.rpuEn     := usb2TxLogic.io.rpuEn    
  io.vpo       := usb2TxLogic.io.vpo      
  io.oeb       := usb2TxLogic.io.oeb      
  io.hsData    := usb2TxLogic.io.hsData   
  io.hsDriveEn := usb2TxLogic.io.hsDriveEn
  io.hsCsEn    := usb2TxLogic.io.hsCsEn  

  io.busy := ~(tx_async.io.enq.ready)

  // Loopback for integration tests
  if (params.loopback) {
    io.cru_fs_vp := io.vpo
    io.cru_fs_vm := ~io.vpo
    io.cru_hs_vp := io.vpo
    io.cru_hs_vm := ~io.vpo
    io.cru_hs_toggle := true.B // Tie to 1 in HS mode
  }
}
// DOC include end: usb2 chisel

// DOC include start: usb2 router
class Usb2TL(params: Usb2Params, beatBytes: Int)(implicit p: Parameters) extends ClockSinkDomain(ClockSinkParameters())(p) {
  val mmio_device = new SimpleDevice("LoopBack", Seq("eecs251b,usb2")) 
  val mmio_node = TLRegisterNode(Seq(AddressSet(params.address, 4096-1)), mmio_device, "reg/control", beatBytes=beatBytes)

  override lazy val module = new Usb2Impl
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
      impl.io.cru_fs_vp      := 0.S
      impl.io.cru_fs_vm      := 0.S
      impl.io.cru_hs_vp      := 0.S
      impl.io.cru_hs_vm      := 0.S
      impl.io.cru_hs_toggle  := 0.U

      // 200 -> 60
      // impl.io.cru_clk := clock
      // impl.io.utmi_clk := clock

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

trait CanHavePeripheryUsb2 { this: BaseSubsystem =>
  private val portName = "usb2"

  // private val pbus = locateTLBusWrapper(PBUS)

  // Only build if we are using the TL (nonAXI4) version
  val tx_busy = p(Usb2Key) match {
    case Some(params) => {
      val usb2 = pbus { LazyModule(new Usb2TL(params, pbus.beatBytes)(p)) }
      // usb2.clockNode := pbus.fixedClockNode
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

// TODO: what other params should be passed?
class WithUsb2(params: Usb2Params) extends Config((site, here, up) => {
  case Usb2Key => Some(params)
})
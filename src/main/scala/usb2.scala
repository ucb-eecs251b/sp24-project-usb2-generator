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
  // D+
  // D-

}

case class Usb2Params(
	// config params
  // TODO: use real params, these are just for the loopback
	address: BigInt = 0x7000,
  depth: Int = 32, 
  width: Int = 32,
)


class Usb2Top(params: Usb2Params, beatBytes: Int)(implicit p: Parameters) extends ClockSinkDomain(ClockSinkParameters())(p) {
	// TODO: turn this UTMI verilog interface into chisel
	/*
  	// UTMI Interface 
	output utmi_clk, // FIXME: whether this will be separate from the analog-interface clock 
	// UTMI Controls 
	input utmi_xcvr_select, // Transceiver Select
	input utmi_term_select, // Termination Select
	input utmi_suspend_n, // Active-Low Suspend 
	output [1:0] utmi_line_state, // Received Line State
	input [1:0] utmi_opmode, // Operation Mode
	// UTMI TX 
	input [7:0] utmi_datain, // TX Data Input
	input utmi_tx_valid, // TX Valid 
	output utmi_tx_ready, // TX Ready
	// UTMI RX 
	output [7:0] utmi_dataout, // RX Data Output
	output utmi_rx_valid, // RX Valid
	output utmi_rx_active, // RX Active
	output utmi_rx_error, // RX Error
	*/
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

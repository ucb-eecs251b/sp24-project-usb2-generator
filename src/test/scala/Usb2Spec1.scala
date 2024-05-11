package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import scala.util.Random

object FailureMode extends Enumeration {
  type Type = Value
  val None, Test = Value
}

class Usb2UtmiTest(
    dataWidth: Int,
    failureMode: FailureMode.Type
) extends Module {
  val io = IO(new Bundle {
    // interface
    val reset = Input(UInt(1.W))
    val mmio_tx_data = Input(UInt(dataWidth.W))
    val mmio_tx_valid = Input(Bool())
    val mmio_tx_ready = Output(Bool())
    val asyncQ_tx_data = Output(UInt(dataWidth.W))
    // val a = Output(UInt(dataWidth.W))
    // val why = Input(UInt(1.W)) // just testing how to initialize io - doesn't work

    val mmio_tx_busy = Output(Bool())

    val mmio_rx_ready = Input(Bool())
    val mmio_rx_valid = Output(Bool())
    val mmio_rx_data = Output(UInt(dataWidth.W+2)) // right?

    val utmi_linestate = Output(UInt(2.W)); 
    val data_d_plus = Input(UInt(1.W));
    val data_d_minus = Input(UInt(1.W));  
    val cru_hs_toggle = Input(UInt(1.W))
  })
  val usb2 = Module(new Usb2Top(Usb2Params()))
  // usb2.io.why := io.why
  usb2.io.mmio_tx_data := io.mmio_tx_data
  usb2.io.mmio_tx_valid := io.mmio_tx_valid
  io.asyncQ_tx_data := usb2.io.asyncQ_tx_data // unsure if this will work
  io.mmio_tx_ready := usb2.io.mmio_tx_ready // if tx mmio register is reading from c address (busy)
  usb2.io.reset := io.reset
  usb2.io.mmio_rx_ready := io.mmio_rx_ready
  io.mmio_rx_valid := 0.U// usb2.rx_async.io.deq.valid // unclear
  io.mmio_rx_data := "h0000000000".asUInt(10.W)// usb2.rx_async.io.deq.bits // unclear

  // todo: assign other IOs
  io.mmio_tx_busy := usb2.io.busy // unsure

  // todo check rx logic if necessary
  usb2.io.cru_hs_toggle  := io.cru_hs_toggle
  io.utmi_linestate := usb2.io.utmi_linestate //todo
  usb2.io.data_d_plus := io.data_d_plus //todo
  usb2.io.data_d_minus := io.data_d_minus  //todo
}

/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * {{{
  * testOnly usb2.Usb2Spec1
  * }}}
  * From a terminal shell use:
  * {{{
  * sbt 'testOnly usb2.Usb2Spec1'
  * }}}
  */
class Usb2Spec1 extends AnyFreeSpec with ChiselScalatestTester {
  "Path from UTMI to TX logic correctly handles random UTMI data input" in {
    test(
      new Usb2UtmiTest(
        8, // necessary ..? to be configurable
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        dut.clock.setTimeout(0) // infinite timeout
        val randomData = Random.nextInt(256)
        dut.io.reset.poke(false.B)
        dut.io.mmio_rx_ready.poke(false.B)
        dut.io.mmio_tx_data.poke(randomData.U(8.W))
        dut.io.mmio_tx_valid.poke(true.B)
        dut.clock.step()
        // tx busy?
        var TIMEOUT_CYCLES = 100
        var timeout = 0
        // println("random test data =", randomData, randomData.toHexString)
        while ((dut.io.asyncQ_tx_data.peek().litValue !== randomData.U.litValue) && timeout < TIMEOUT_CYCLES) { //randomData.U.litValue
          dut.clock.step()
          timeout += 1
        }
        assert(timeout < TIMEOUT_CYCLES, s"Timeout occurred waiting for TX logic to process data: 0x${randomData.toHexString}")// 0x${randomData.toHexString}
        dut.io.asyncQ_tx_data.expect(randomData.U(8.W), s"Expected data 0x${randomData.toHexString} did not appear on TX logic")
    }
  }

  "Path from UTMI to TX logic should correctly handle random UTMI data inputs" in {
    test(
      new Usb2UtmiTest(
        8, // necessary ..? to be configurable
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        dut.clock.setTimeout(0) // infinite timeout
        for (_ <- 1 to 100) {
          val randomData = Random.nextInt(256)
          dut.io.reset.poke(false.B)
          dut.io.mmio_rx_ready.poke(false.B)
          dut.io.mmio_tx_data.poke(randomData.U(8.W))
          // valid should only be high one cycle
          dut.io.mmio_tx_valid.poke(true.B)
          dut.clock.step()
          dut.io.mmio_tx_valid.expect(true.B)
          dut.io.mmio_tx_data.expect(randomData.U(8.W))
          // tx busy?
          var TIMEOUT_CYCLES = 10000
          var timeout = 0
          // println("random test data =", randomData, randomData.toHexString)
          while ((dut.io.asyncQ_tx_data.peek().litValue !== randomData.U.litValue) && timeout < TIMEOUT_CYCLES) { //randomData.U.litValue
            // println("asyncQ_tx_data =", dut.io.asyncQ_tx_data.peek())
            dut.clock.step()
            if (dut.io.mmio_tx_ready.peek().litToBoolean === true.B.litValue) {
              dut.io.mmio_tx_valid.poke(false.B)
              dut.io.mmio_tx_valid.expect(false.B)
            }
            timeout += 1
          }
          assert(timeout < TIMEOUT_CYCLES, s"Timeout occurred waiting for TX logic to process data: 0x${randomData.toHexString}")// 0x${randomData.toHexString}
          dut.io.asyncQ_tx_data.expect(randomData.U(8.W), s"Expected data 0x${randomData.toHexString} did not appear on TX logic")
        }
    }
  }

}
package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

object FailureMode extends Enumeration {
  type Type = Value
  val None = Value
}

class usb2TopTest(
    failureMode: FailureMode.Type
) extends Module {
  val usb2Params = Usb2Params(address = 0x7000, depth = 32, width = 8, asyncQueueSz = 8)
  val usb2 = Module(new Usb2Top(usb2Params, beatBytes = 8))
}

class writingToUtmiDataIn extends AnyFreeSpec with ChiselScalatestTester {

  "Serial to Parallel Convertor Test 1" in {
    test(
      new usb2TopTest(
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        dut.utmi_datain.bits.poke("hFF".U(8.W))
        dut.clock.step()
        dut.utmi_datain.valid.expect(true.B)
        var timeout = 0
        while (dut.usb2RxLogic.io.in.bits.peek().litValue != "hFF".U(8.W).litValue && timeout < 1000) {
            dut.clock.step()
            timeout += 1
        }
        dut.usb2RxLogic.io.in.bits.expect("hFF".U(8.W))
    }
  }
}
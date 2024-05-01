package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

class UsbUtmiSpec extends AnyFreeSpec with ChiselScalatestTester {

  "UTMI Data Input Random Testing" - {
    "RX Serial to Parallel Convertor should correctly handle random UTMI data inputs" in {
      test(
        new Usb2Top(beatBytes = 8)
      ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (_ <- 1 to 100) {
          val randomData = Random.nextInt(256)
          dut.utmi_datain.bits.poke(randomData.U(8.W))
          dut.utmi_datain.valid.poke(true.B)
          dut.clock.step()
          dut.utmi_datain.valid.expect(true.B)

          var timeout = 0
          while (dut.rxLogic.io.in.bits.peek().litValue != randomData.U.litValue && timeout < 1000) {
            dut.clock.step()
            timeout += 1
          }
          assert(timeout < 1000, s"Timeout occurred waiting for RX logic to process data: 0x${randomData.toHexString}")
          dut.rxLogic.io.in.bits.expect(randomData.U(8.W), s"Expected data 0x${randomData.toHexString} did not appear on RX logic")
        }
      }
    }
  }
}
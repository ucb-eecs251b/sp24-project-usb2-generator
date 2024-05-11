package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

class UsbUtmiSpec extends AnyFreeSpec with ChiselScalatestTester {

  "UTMI Data Input Random Testing" - {
    "Path from UTMI to TX logic should correctly handle random UTMI data inputs" in {
      test(
        new Usb2Top(beatBytes = 8)
      ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (_ <- 1 to 100) {
          val randomData = Random.nextInt(256).U(8.W)
          dut.utmi_datain.bits.poke(randomData)
          dut.utmi_datain.valid.poke(true.B)
          var timeout = 0
          while (dut.txLogic.io.in.bits.peek().litValue != randomData.U.litValue && timeout < 1000) {
            dut.clock.step()
            timeout += 1
          }
          assert(timeout < 1000, s"Timeout occurred waiting for TX logic to process data: 0x${randomData.toHexString}")
          dut.txLogic.io.in.bits.expect(randomData, s"Expected data 0x${randomData.toHexString} did not appear on TX logic")
        }
      }
    }
  }

  "RX NonError Data Input Random Testing" - {
    "Data from RX should eventually be recieved in UTMI" in {
      test(
        new Usb2Top(beatBytes = 8)
      ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (_ <- 1 to 100) {
          val rxError = false.B
          val rxActive = true.B
          val rxToUtmiData = Random.nextInt(256).U(8.W)
          val expectedData = Cat(Cat(rxError, rxActive), rxToUtmiData).U(10.W)
          usb2RxLogic.io.utmi_rx_error.poke(rxError)
          usb2RxLogic.io.utmi_rx_active.poke(rxActive)
          usb2RxLogic.io.utmi_dataout.poke(rxToUtmiData)
          usb2RxLogic.io.utmi_rx_valid.poke(true.B)
          var timeout = 0
          while (dut.rx_bundle.peek().litValue != expectedData.U.litValue && timeout < 1000) {
            dut.clock.step()
            timeout += 1
          }
          assert(timeout < 1000, s"Timeout occurred waiting for RX logic to process data: 0x${expectedData.toHexString}")
          dut.rx_bundle.expect(expectedData, s"Expected data 0x${expectedData.toHexString} did not appear from RX logic")
        }
      }
    }
  }

  "RX Error Data Input Random Testing" - {
    "Error should propogate from RX module to UTMI module" in {
      test(
        new Usb2Top(beatBytes = 8)
      ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (_ <- 1 to 100) {
          val rxError = true.B
          val rxActive = true.B
          val rxToUtmiData = 0xFF.U(8.W)
          val expectedData = Cat(Cat(rxError, rxActive), rxToUtmiData).U(10.W)
          usb2RxLogic.io.utmi_rx_error.poke(rxError)
          usb2RxLogic.io.utmi_rx_active.poke(rxActive)
          usb2RxLogic.io.utmi_dataout.poke(rxToUtmiData)
          usb2RxLogic.io.utmi_rx_valid.poke(true.B)
          var timeout = 0
          while (dut.rx_bundle.peek().litValue != expectedData.U.litValue && timeout < 1000) {
            dut.clock.step()
            timeout += 1
          }
          assert(timeout < 1000, s"Timeout occurred waiting for RX logic to process data: 0x${expectedData.toHexString}")
          dut.rx_bundle.expect(expectedData, s"Expected data 0x${expectedData.toHexString} did not appear from RX logic")
        }
      }
    }
  }
}
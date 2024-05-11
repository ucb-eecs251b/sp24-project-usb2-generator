package usbtx

import chisel3._
import chisel3.experimental.BundleLiterals._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.must.Matchers
import scala.collection.mutable.Buffer

class USBTxSerializerSpec extends AnyFreeSpec with Matchers {
  
  def hsClock(dut: USBTxSerializer): Unit = {
    for (i <- 0 until 8) {
      dut.io.clockOut.step()
      println(s"i: $i")
      println(s"sDataOut: ${dut.io.sDataOut.bits.peek().litValue.toInt}")
    }
    dut.clock.step()
    println("clock")
  }


  "when clockOut is faster" in {
    simulate(new USBTxSerializer(16)) { dut =>
      dut.io.xcvrSelect.poke(0.U)

      val input = 0xAAAA.U
      dut.io.pDataIn.valid.poke(true.B)
      dut.io.sDataOut.ready.poke(true.B)
      dut.io.pDataIn.bits.poke(input)

      hsClock(dut)
    }
  }

}

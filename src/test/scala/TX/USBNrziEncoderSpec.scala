package usbtx

import chisel3._
import chisel3.experimental.BundleLiterals._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.must.Matchers
import scala.collection.mutable.Buffer

class USBNrziEncoderSpec extends AnyFreeSpec with Matchers {

  def testNRZI(input: Seq[Int], expectedOutput: Seq[Int]): Unit = {
    simulate(new USBNrziEncoder()) { dut =>
      val outputBuffer = Buffer[Int]()

      dut.reset.poke(true.B)
      dut.clock.step()

      dut.reset.poke(false.B)
      dut.io.en.poke(true.B)
      var idx = 0

      while (idx < input.length) {
        dut.io.dIn.poke(input(idx).U)
        dut.clock.step()
        outputBuffer += dut.io.dOut.peek().litValue.toInt
        idx += 1
      }

      println(s"Initial state: 1'b0")
      println(s"Input sequence: ${input.mkString(", ")}")
      println(s"Output sequence: ${outputBuffer.sliding(2).map(pair => s"(${pair.head} -> ${pair.last})").mkString(" ")}")

      outputBuffer mustBe expectedOutput
    }
  }

    "all ones, no change" in {
      val input          = Seq[Int](1, 1, 1, 1, 1, 1, 1, 1)
      val expectedOutput = Seq[Int](1, 1, 1, 1, 1, 1, 1, 1)
      testNRZI(input, expectedOutput)
    }

    "all zeros, should change state constantly" in {
      val input           = Seq[Int](0, 0, 0, 0, 0, 0, 0, 0)
      val expectedOutput  = Seq[Int](1, 0, 1, 0, 1, 0, 1, 0)
      testNRZI(input, expectedOutput)
    }

    "varying sequence" in {
      val input           = Seq[Int](0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1)
      val expectedOutput  = Seq[Int](1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0)
      testNRZI(input, expectedOutput)
    }

}

package usbtx

import chisel3._
import chisel3.experimental.BundleLiterals._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.must.Matchers
import scala.collection.mutable.Buffer

class USBBitStufferSpec extends AnyFreeSpec with Matchers {

  def testBitStuffer(input: Seq[Int], expectedOutput: Seq[Int]): Unit = {
    simulate(new USBBitStuffer()) { dut =>
      val outputBuffer = Buffer[Int]()

      dut.reset.poke(true.B)
      dut.clock.step()

      dut.reset.poke(false.B)
      dut.io.en.poke(true.B)
      dut.io.dataOut.ready.poke(true.B)
      dut.io.dataIn.valid.poke(true.B)
      dut.clock.step()

      var idx = 0

      while (idx < input.length) {

        //println(s"ready: ${dut.io.dataIn.ready.peek().litToBoolean}")
        if (dut.io.dataIn.ready.peek().litToBoolean) {
          dut.io.dataIn.bits.poke(input(idx).U)
          idx += 1
        }

        //println(s"test: ${dut.io.test.peek().litValue.toInt}")
        //println(s"outBits: ${dut.io.dataOut.bits.peek().litValue.toInt}")
        //println(s"cnt: ${dut.io.cnt.peek().litValue.toInt}")
        outputBuffer += dut.io.dataOut.bits.peek().litValue.toInt
        dut.clock.step()
      }

      dut.io.dataIn.valid.poke(false.B)
      (1 to 10).foreach { _ =>
        dut.clock.step()
        if (dut.io.dataOut.valid.peek().litToBoolean) {
          outputBuffer += dut.io.dataOut.bits.peek().litValue.toInt
        }
      }

      //println(s"Input sequence: \t${input.mkString(", ")}")
      //println(s"Final output sequence: \t${outputBuffer.mkString(", ")}")
      outputBuffer mustBe expectedOutput
    }
  }


  "no stuffing necessary" in {
      val input = Seq[Int](1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0)
      val expectedOutput = Seq[Int](1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0)
      testBitStuffer(input, expectedOutput)
  }

  "should insert a zero after six consecutive ones" in {
      val input = Seq(0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1)  // Seven '1's to test stuffing
      val expectedOutput = Seq(0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1) // Expected output includes a zero after six '1's
      testBitStuffer(input, expectedOutput)
  }

  "should manage multiple stuffing conditions" in {
      val input = Seq(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)  // Thirteen '1's to test double stuffing
      val expectedOutput = Seq(1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1) // Includes two zeros inserted
      testBitStuffer(input, expectedOutput)
  }

  "should manage stuffing at the end of the input" in {
      val input = Seq(1, 1, 1, 1, 1, 1)  // Nine '1's to test stuffing at the end
      val expectedOutput = Seq(1, 1, 1, 1, 1, 1, 0) // Includes a zero inserted at the end
      testBitStuffer(input, expectedOutput)
  }

}

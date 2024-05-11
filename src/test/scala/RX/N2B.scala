package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import firrtl2.Utils
import org.scalatest.Assertions._

object FailureMode extends Enumeration {
  type Type = Value
  val None = Value
}

// NRZI decoder test
class NRZITest(
    failureMode: FailureMode.Type
) extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(1.W))
    val dataOut = Output(UInt(1.W))
    val enable = Input(UInt(1.W))
  })
  val nrzi = Module(new NRZIDecoder())
  nrzi.io.dataIn := io.dataIn
  io.dataOut := nrzi.io.dataOut
  nrzi.io.enable := io.enable
}

// Bit Unstuffer test
class BitUnstufferTest(
    failureMode: FailureMode.Type
) extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(1.W))
    val dataOut = Output(UInt(1.W))
    val error = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val enable = Input(UInt(1.W))
  })
  val b_unstuff = Module(new BitUnstuffer())
  b_unstuff.io.dataIn := io.dataIn
  io.dataOut := b_unstuff.io.dataOut
  io.error := b_unstuff.io.error
  io.valid := b_unstuff.io.valid
  b_unstuff.io.enable := io.enable
}

// NRZI decoder with bit unstuffing test
class N2BTest(
    failureMode: FailureMode.Type
) extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(1.W))
    val dataOut = Output(UInt(16.W))
    val error = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val ready = Output(UInt(1.W))
    val enable = Input(UInt(1.W))
  })
  val nrzi = Module(new NRZIDecoder())
  nrzi.io.dataIn := io.dataIn
  nrzi.io.enable := io.enable
  val b_unstuff = Module(new BitUnstuffer())
  b_unstuff.io.dataIn := nrzi.io.dataOut
  io.error := b_unstuff.io.error
  io.valid := b_unstuff.io.valid
  b_unstuff.io.enable := io.enable
  val s2p = Module(new Serial2ParallelConverter())
  s2p.io.dataIn := b_unstuff.io.dataOut
  s2p.io.valid := b_unstuff.io.valid
  io.ready := s2p.io.ready
  io.dataOut := s2p.io.dataOut 
}

/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * sbt 'testOnly usb2.NRZI'
  * NRZI to Bit Unstuffer
  */
class NRZI extends AnyFreeSpec with ChiselScalatestTester {

  "NRZI Test 1" in {
    test(
      new NRZITest(
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // dummy serial data
      // Data : 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0
      // NRZI Encode
      val nrziEncodedData = Seq(0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0)
      var prev = 1
      dut.io.enable.poke(1.U)
      var output = Seq[Int]()
      for (i <- nrziEncodedData) {
        dut.io.dataIn.poke(i.U)
        val expectedOutput = if ((i === prev)) 1 else 0
        dut.io.dataOut.expect(expectedOutput.U)
        prev = i
        output = output :+ expectedOutput
        dut.clock.step(1)
      }
      val data = Seq(0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0)
      assert (output == data)
    }
  }
}

/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * sbt 'testOnly usb2.BitUnstuff'
  * Bit Unstuffer test
  */
class BitUnstuff extends AnyFreeSpec with ChiselScalatestTester {

  "Bit Unstuffer Test 1" in {
    test(
      new BitUnstufferTest(
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      //                                  S (Stuffed bit)
      val data = Seq(0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0)
      var output = Seq[Int]()
      dut.io.enable.poke(1.U)
      for (i <- data) {
        dut.io.dataIn.poke(i.U)
        dut.io.error.expect(0.U)
        if (dut.io.valid.peekInt() === 1) {
          dut.io.dataOut.expect(i.U)
          output = output :+ i
        } else {
          dut.io.dataOut.expect(0.U)
          dut.io.valid.expect(0.U)
        }
        dut.clock.step(1)
      }
      val result = Seq(0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0)
      assert (output == result)
    }
  }

  "Bit Unstuffer Test 2: Error" in {
    test(
      new BitUnstufferTest(
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      //                                  S (Stuffed bit)
      val data = Seq(0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0)
      var output = Seq[Int]()
      var counter = 0;
      dut.io.enable.poke(1.U)
      for (i <- data) {
        dut.clock.step(1)
        dut.io.dataIn.poke(i.U)
        if ((counter % 7) == 0 && (counter != 0)) {
          dut.io.error.expect(1.U)
        } else {
          dut.io.error.expect(0.U)
        }
        if (dut.io.valid.peekInt() === 1) {
          dut.io.dataOut.expect(i.U)
          output = output :+ i
        } else {
          dut.io.dataOut.expect(0.U)
          dut.io.valid.expect(0.U)
        }
        if (i == 1) {
          counter = counter + 1
        }
      }
      val result = Seq(0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0)
      assert (output == result)
    }
  }
}

/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * sbt 'testOnly usb2.N2B'
  * NRZI to Bit Unstuffer to S2P
  */
class N2B extends AnyFreeSpec with ChiselScalatestTester {

  "N2B Test 1 (No stuff case)" in {
    test(
      new N2BTest (
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // dummy serial data
      // Data : 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1 
      // NRZI Encode
      val nrziEncodedData = Seq(0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0)  
      dut.io.enable.poke(1.U)
      for (i <- nrziEncodedData) {
        dut.io.dataIn.poke(i.U)
        dut.io.error.expect(0.U)
        dut.clock.step(1)
      }
      dut.clock.step(1)
      dut.io.ready.expect(1.U)
      dut.io.dataOut.expect("h3E4D".U)
    }
  }

  "N2B Test 2 (Stuff Case)" in {
    test(
      new N2BTest (
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // dummy serial data
      // Data : 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0    #stuffed bit added so length 17
      // NRZI Encode
      val nrziEncodedData = Seq(0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0)  
      dut.io.enable.poke(1.U)
      for (i <- nrziEncodedData) {
        dut.io.dataIn.poke(i.U)
        dut.io.error.expect(0.U)
        dut.clock.step(1)
      }
      dut.clock.step(1)
      dut.io.ready.expect(1.U)
      // Data Recovered: Seq(0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0)
      dut.io.dataOut.expect("h7FA2".U)
    }
  }

  "N2B Test 3 (Invalid Case)" in {
    test(
      new N2BTest (
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // dummy serial data
      // Data : 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0    #stuffed bit added so length 17
      // NRZI Encode
      val nrziEncodedData = Seq(1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0)  
      dut.io.enable.poke(0.U)
      for (i <- nrziEncodedData) {
        dut.io.dataIn.poke(i.U)
        dut.io.error.expect(0.U)
        dut.clock.step(1)
        dut.io.enable.poke(1.U)
      }
      dut.clock.step(1)
      dut.io.ready.expect(1.U)
      // Data Recovered: Seq(0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0)
      dut.io.dataOut.expect("h7FA2".U)
    }
  }
}
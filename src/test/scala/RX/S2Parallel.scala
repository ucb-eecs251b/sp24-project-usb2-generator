package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

object FailureModes extends Enumeration {
  type Type = Value
  val None = Value
}

class S2PTest(
    dataWidth: Int,
    failureMode: FailureModes.Type
) extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(1.W))
    val dataOut = Output(UInt(dataWidth.W))
    val ready = Output(UInt(1.W))
    val valid = Input(UInt(1.W))
  })
  val s2p = Module(new Serial2ParallelConverter(dataWidth))
  s2p.io.dataIn := io.dataIn
  s2p.io.valid := io.valid
  io.dataOut := s2p.io.dataOut
  io.ready := s2p.io.ready
}

/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * sbt 'testOnly usb2.S2Parallel'
  * Chisel doesn't allow multiple clock domains, but I can at least test that the data 
  * I get back is parallel (not really).
  */
class S2Parallel extends AnyFreeSpec with ChiselScalatestTester {

  "Serial to Parallel Convertor Test 1" in {
    test(
      new S2PTest(
        16,
        FailureModes.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // dummy serial data
      dut.io.valid.poke(1.U)
      val inSeq = Seq(0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0)
      for (i <- inSeq) {
        dut.io.dataIn.poke(i.U)
        dut.clock.step(1)
      }
      dut.clock.step(1)
      dut.io.ready.expect(1.U)
      // 16 bit parallelize data
      dut.io.dataOut.expect("h766C".U(16.W))
    }
  }

   "Serial to Parallel Convertor Test 2" in {
    test(
      new S2PTest(
        16,
        FailureModes.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // dummy serial data
      val inSeq = Seq(0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1)
      dut.io.valid.poke(0.U) // trigger no valid
      for (i <- inSeq) {
        dut.io.dataIn.poke(i.U)
        dut.clock.step(1)
        dut.io.valid.poke(1.U)
      }
      dut.clock.step(1)
      dut.io.ready.expect(1.U)
      // 16 bit parallelize data
      dut.io.dataOut.expect("hECD9".U(16.W))
    }
  }
}
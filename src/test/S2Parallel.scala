package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

object FailureMode extends Enumeration {
  type Type = Value
  val None = Value
}

class S2PTest(
    dataWidth: Int,
    failureMode: FailureMode.Type
) extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(dataWidth.W))
    val dataOut = Output(UInt(dataWidth.W))
  })
  val s2p = Module(new Serial2ParallelConverter(dataWidth))
  s2p.io.datain := io.dataIn;
  io.dataOut := s2p.io.dataout
}

/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * {{{
  * testOnly srambist.SramBistSpec
  * }}}
  * From a terminal shell use:
  * {{{
  * sbt 'testOnly srambist.SramBistSpec'
  * }}}
  */
class S2Parallel extends AnyFreeSpec with ChiselScalatestTester {

  "Serial to Parallel Convertor Test 1" in {
    test(
      new S2PTest(
        16,
        FailureMode.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.dataIn.poke("hFFFFFFFF".U(32.W))
      dut.clock.step()
      
      dut.io.dataOut.expect(false.B)
    }
  }
}

/* Basic Chisel sanity test */
// for (i <- Seq(8, 16)) {
//     println(s"Testing Serial2ParallelConverter dataWidth=$i")
//     test(new Serial2ParallelConverter) { mod =>
//         val inSeq = Seq(0, 1, 1, 1, 0, 1, 1, 0, 0, 1)
//         var state = 0
//         var i = 0
//         for (i <- 10 * mod.dataWidth) {fsd
//             // poke in repeated inSeq
//             val toPoke = inSeq(i % inSeq.length)
//             mod.io.datain.poke((toPoke != 0).B)
//             // update expected state
//             state = ((state * 2) + toPoke) 
//             mod.clock.step(1)
//             c.io.out.expect(state.U)
//         }
//     }
// }
// println(s"Testing Serial2ParallelConverter: Success")

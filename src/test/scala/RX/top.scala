package usb2

import chisel3._
import chisel3.util.log2Ceil
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec

/** Top Level Testbench **/
class TopTest(
    dataWidth: Int,
    failureMode: FailureModes.Type
) extends Module {
  val io = IO(new Bundle {
    val dataout = Output(UInt(dataWidth.W))
    val rx_valid = Output(UInt(1.W))
    val rx_active = Output(UInt(1.W))
    val rx_error = Output(UInt(1.W))
    val rx_linestate = Output(UInt(2.W))
    
    val data_plus = Input(UInt(1.W))
    val data_minus = Input(UInt(1.W))
    val hs_mode = Input(UInt(1.W))
  })
  val rx = Module(new USB_RX(dataWidth))
  rx.io.cru_hs_toggle := io.hs_mode
  rx.io.data_d_minus := io.data_minus
  rx.io.data_d_plus := io.data_plus
  rx.io.clk := clock

  io.dataout := rx.io.utmi_dataout
  io.rx_valid := rx.io.utmi_rx_valid
  io.rx_active := rx.io.utmi_rx_active
  io.rx_error := rx.io.utmi_rx_error
  io.rx_linestate := rx.io.utmi_linestate
  
}



/** This is a trivial example of how to run this Specification From within sbt
  * use:
  * sbt 'testOnly usb2.RXTOP'
  */
class RXTOP extends AnyFreeSpec with ChiselScalatestTester {
  def repeatPattern(pattern: Seq[Int], times: Int): Seq[Int] = {
    (1 to times).flatMap(_ => pattern)
  }

  "Top level Test 1 (FS)" in {
    test(
      new TopTest(
        16,
        FailureModes.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.io.hs_mode.poke(0.U)
      // {SYNC, DATA, EOP}
      // Stay in IDLE so bunch of 1s at the start (5 ones)
      val dataPlus = Seq(1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1)
      val dataMinus = Seq(0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0)
      dataPlus.zip(dataMinus).foreach { case (plus, minus) =>
        // println(dut.io.dataout.peek())
        if (dut.io.rx_valid.peekInt() == 1) {
          dut.io.dataout.expect("h6A26".U(16.W))
        }
        dut.io.data_plus.poke(plus.U)
        dut.io.data_minus.poke(minus.U)
        dut.io.rx_error.expect(0.U)
        dut.clock.step(1)
      }
      dut.io.rx_active.expect(0.U)
      dut.io.rx_valid.expect(0.U)
    }
  }

  "Top level Test 2 (HS)" in {
    test(
      new TopTest(
        16,
        FailureModes.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.io.hs_mode.poke(1.U)
      // {SYNC, DATA, EOP}
      // Stay in IDLE so bunch of 1s at the start (5 ones)
      // I guess this is one cleaner way to right it thanks google
      val dataPlus = Seq(1, 1, 1, 1, 1) ++ repeatPattern(Seq(0, 1), 15) ++ Seq(0, 0) ++  Seq(0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0) ++ Seq(1, 1, 1, 1, 1, 1, 1, 1)
      val dataMinus = Seq(0, 0, 0, 0, 0) ++ repeatPattern(Seq(1, 0), 15) ++ Seq(1, 1) ++ Seq(1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1) ++ Seq(0, 0, 0, 0, 0, 0, 0, 0)
      dataPlus.zip(dataMinus).foreach { case (plus, minus) =>
        if (dut.io.rx_valid.peekInt() === 1) {
          // println("WEEEEE")
          dut.io.dataout.expect("h6A26".U(16.W))
        }
        dut.io.data_plus.poke(plus.U)
        dut.io.data_minus.poke(minus.U)
        dut.io.rx_error.expect(0.U)
        dut.clock.step(1)
      }
      dut.io.rx_active.expect(0.U)
      dut.io.rx_valid.expect(0.U)
    }
  }

  "Top level Test 3 Error" in {
    test(
      new TopTest(
        16,
        FailureModes.None
      )
    ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.io.hs_mode.poke(1.U)
      // {SYNC, DATA, EOP}
      // Stay in IDLE so bunch of 1s at the start (5 ones)
      // I guess this is one cleaner way to right it thanks google
      val dataPlus = Seq(1, 1, 1, 1, 1) ++ repeatPattern(Seq(0, 1), 15) ++ Seq(0, 0) ++  Seq(0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0) ++ Seq(1, 1, 1, 1, 1, 1, 1, 1)
      val dataMinus = Seq(0, 0, 0, 0, 0) ++ repeatPattern(Seq(1, 0), 15) ++ Seq(1, 1) ++ Seq(1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1) ++ Seq(0, 0, 0, 0, 0, 0, 0, 0)
      dataPlus.zip(dataMinus).foreach { case (plus, minus) =>
        if (dut.io.rx_error.peekInt() === 1) {
          println("WEEEEE")
          dut.io.rx_error.expect(1.U)
        } else {
          dut.io.rx_error.expect(0.U)
        }
        dut.io.data_plus.poke(plus.U)
        dut.io.data_minus.poke(minus.U)
        dut.clock.step(1)
      }
      dut.io.rx_active.expect(0.U)
      dut.io.rx_valid.expect(0.U)
    }
  }
}

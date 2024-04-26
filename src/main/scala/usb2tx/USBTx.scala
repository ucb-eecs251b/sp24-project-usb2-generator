package usb2

import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.subsystem._
import freechips.rocketchip.tilelink._
import scala.annotation.switch

object USBTxTransitions {
  object State extends ChiselEnum {
    val Idle, SyncGenerate, DataTransmit, EOPGenerate = Value
  }
}

class USBTxStates(dWidth: Int) extends Module {
  import USBTxTransitions.State
  import USBTxTransitions.State._

  val io = IO(new Bundle {
    val rst_i = Input(Bool())
    val tx_valid_i = Input(Bool())
    val tx_data_i = Input(UInt(dWidth.W))
    val serial_clk = Input(Clock())
    
    val tx_en_o = Output(Bool())
    val tx_dp_o = Output(Bool())
    val tx_dn_o = Output(Bool())
    val tx_ready_o = Output(Bool())
  })

  val state = RegInit(State.Idle)
  val bit_cnt = RegInit(7.U(3.W))
  val data = RegInit("b1000_0000".U(8.W))
  val stuff_cnt = RegInit(0.U(3.W))
  val nrzi = RegInit(true.B)
  val tx_ready = RegInit(false.B)

  io.tx_en_o := state =/= State.Idle
  io.tx_dp_o := Mux(state === State.EOPGenerate && data(0) === 0.U, false.B, nrzi)
  io.tx_dn_o := Mux(state === State.EOPGenerate && data(0) === 1.U, false.B, !nrzi)
  io.tx_ready_o := tx_ready


  withClock(io.serial_clk) {
    when(io.rst_i) {
      state := State.Idle
      bit_cnt := 7.U
      data := "b1000_0000".U
      stuff_cnt := 0.U
      nrzi := true.B
      tx_ready := false.B
    }.otherwise {
      switch(state) {
        is(State.Idle) {
          when(io.tx_valid_i) {
            state := State.SyncGenerate
          }
        }
        is(State.SyncGenerate) {
          when(bit_cnt === 0.U) {
            state := State.DataTransmit
            bit_cnt := 7.U
            data := io.tx_data_i
            tx_ready := true.B
          }.otherwise {
            bit_cnt := bit_cnt - 1.U
          }
        }
        is(State.DataTransmit) {
          when(bit_cnt === 0.U) {
            state := State.EOPGenerate
            bit_cnt := 3.U
            data := "b1111_1001".U
            tx_ready := false.B
          }.otherwise {
            bit_cnt := bit_cnt - 1.U
          }
        }
        is(State.EOPGenerate) {
          when(bit_cnt === 0.U) {
            state := State.Idle
          }.otherwise {
            bit_cnt := bit_cnt - 1.U
          }
        }
      }

      data := data >> 1
      when(data(0)) {
        stuff_cnt := Mux(stuff_cnt === 6.U, 0.U, stuff_cnt + 1.U)
        nrzi := Mux(stuff_cnt === 6.U, !nrzi, nrzi)
      }.otherwise {
        stuff_cnt := 0.U
        nrzi := !nrzi
      }
    }
  }
}


class USBTx(dWidth: Int) extends Module {
  /**  Explicit parameterization might not be needed
    *  Otherwise can use dWidth/2 (with requrire(dWidth % 2 == 0))
    */
  val io = IO(new Bundle {
    /** UTMI signals 
     *  validH is incorporated in 'in' as in.valid */
    val in = Flipped(Decoupled(UInt(dWidth.W)))

    /** Not sure if needed */
    val tx_busy = Output(Bool())

    /**  TX driver signals */
    /* Pull-up resistor enable */
    val rpuEn = Output(UInt(1.W))

    val fs_xmt_data = Output(UInt(1.W))
    val seo         = Output(UInt(1.W))
    val oe          = Output(UInt(1.W))

    /* HS transmit data 
     * Pin names from USB System Arch. by Don Anderson */
    val hs_xmt_data = Output(UInt(1.W))
    val hs_drive_en = Output(UInt(1.W))
    val hs_curr_en  = Output(UInt(1.W))
  })


}

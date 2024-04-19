package usb2

import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Parameters, Field, Config}
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.subsystem._
import freechips.rocketchip.tilelink._

object USBTxTransitions {
  object State extends ChiselEnum {
    val Reset, Wait, Transmit, DataConsume, EOPGenerate = Value
  }
}

class USBTxStates extends Module {
  import USBTxTransitions.State
  import USBTxTransitions.State._

  val io = IO(new Bundle {
    val RESET   = Input(Bool())
    val TXVALID = Input(Bool())
    val TXREADY = Output(Bool())
    val state   = Output(State())
  })

  val state = RegInit(Reset)

  io.TXREADY := (state === Transmit) || (state === DataConsume)
  io.state := state

  switch(state) {
    is(Reset) {
      when(!io.RESET) {
        state := Wait
      }
    }
    is(Wait) {
      when(io.TXVALID) {
        state := Transmit
      }
    }
    is(Transmit) {
      when(io.TXVALID && io.TXREADY) {
        state := DataConsume
      }
    }
    is(DataConsume) {
      when(!io.TXVALID) {
        state := EOPGenerate
      }
    }
    is(EOPGenerate) {
      state := Wait
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
    val rpuEn     = Output(UInt(1.W))
    val vpo       = Output(UInt(1.W))
    val oeb       = Output(UInt(1.W))
    val hsData    = Output(UInt(1.W))
    val hsDriveEn = Output(UInt(1.W))
    val hsCsEn    = Output(UInt(1.W))
  })

  /** Tx FSM */
  val txFSM = Module(new USBTxStates)

  txFSM.io.RESET   := !io.validH
  txFSM.io.TXVALID := io.in.valid

  io.tx_busy := (txFSM.io.state === USBPHYTransmitter.State.Transmit) ||
                (txFSM.io.state === USBPHYTransmitter.State.DataConsume)

  val serializer  = Module(new USBTxSerializer(dWidth))
  val bitStuffer  = Module(new USBBitStuffer(serializer.io.dataOut))
  val nrziEncoder = Module(new USBNrziEncoder(bitStuffer.io.dataOut))

  hsData    := nrziEncoder.io.dataOut
}

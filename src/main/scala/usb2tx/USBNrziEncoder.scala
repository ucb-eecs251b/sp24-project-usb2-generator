import chisel3._

class USBNrziEncoder extends Module {
  val io = IO(new Bundle {
    val en = Input(Bool())
    val dataIn = Input(Bool())
    /* External clock */
    val clk = Input(Clock())
    val nrziOut = Output(Bool())
  })

  val lastState = RegInit(false.B)

  withClock(io.clk) {
    when(io.enable) {
      when(io.dataIn) {
        /* If dataIn is '1' -> no change in output (maintain last state) */
        io.nrziOut := lastState
      }.otherwise {
        /* If '0', invert the output */
        io.nrziOut := !lastState
      }
    }.otherwise {
      io.nrziOut := lastState
    }

    /* Update for the next cycle */
    lastState := io.nrziOut
  }
}

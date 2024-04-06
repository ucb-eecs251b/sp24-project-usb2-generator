`timescale 1 ns /  1 ps

module ad_fifo_tb();

reg CRD, Add, Drop, Clock, Reset;
wire Underflow, Overflow, Data;

initial Clock = 0;
always #(`CLOCK_PERIOD/2) Clock <= ~Clock;

ad_fifo dut (
    .CRD(CRD),
    .Add(Add),
    .Drop(Drop),
    .Clock(Clock),
    .Reset(Reset),
    .Underflow(Underflow),
    .Overflow(Overflow),
    .Data(Data)
);

initial begin

$vcdpluson;
    Reset <= 1'b1;
    @(negedge Clock) Reset <= 1'b0;
    repeat(5) @(negedge clk);
    CRD <= 1'b1;
    Add <= 1'b1;
    Drop <= 1'b1;
$vcdplusoff;
$finish;

end

endmodule
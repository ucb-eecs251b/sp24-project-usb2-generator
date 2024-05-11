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
    CRD <= 1'b0;
    Add <= 1'b0;
    Drop <= 1'b0;
    repeat (`FIFO_SIZE) begin // fill entire FIFO with 0,1,0,1...
        @(negedge Clock)
        CRD <= 1'b1;
        Add <= 1'b0;
        Drop <= 1'b0;
        @(negedge Clock)
        CRD <= 1'b0;
        Add <= 1'b0;
        Drop <= 1'b0;
    end
    repeat(2) begin
        @(negedge Clock) // trigger add signal
        CRD <= 1'b1;
        Add <= 1'b1;
        Drop <= 1'b0;
        repeat (1) begin // wait 
            @(negedge Clock)
            CRD <= 1'b0;
            Add <= 1'b0;
            Drop <= 1'b0;
            @(negedge Clock)
            CRD <= 1'b1;
            Add <= 1'b0;
            Drop <= 1'b0;
        end
        @(negedge Clock) // trigger drop signal
        CRD <= 1'b0;
        Add <= 1'b0;
        Drop <= 1'b1;
    end
    repeat (1) begin // wait 
            @(negedge Clock)
            CRD <= 1'b1;
            Add <= 1'b0;
            Drop <= 1'b0;
            @(negedge Clock)
            CRD <= 1'b0;
            Add <= 1'b0;
            Drop <= 1'b0;
        end
    repeat (5) begin // keep switching between Add/Drop
        @(negedge Clock)
        CRD <= 1'b1;
        Add <= 1'b1;
        Drop <= 1'b0;
        @(negedge Clock)
        CRD <= 1'b0;
        Add <= 1'b0;
        Drop <= 1'b1;
    end
    repeat (`FIFO_SIZE / 2) begin // continuous Add; push token to right end
        @(negedge Clock)
        CRD <= 1'b1;
        Add <= 1'b0;
        Drop <= 1'b1;
        @(negedge Clock)
        CRD <= 1'b0;
        Add <= 1'b1;
        Drop <= 1'b0;
    end
    repeat (`FIFO_SIZE) begin // continuous Drop; push token to left end
        @(negedge Clock)
        CRD <= 1'b1;
        Add <= 1'b0;
        Drop <= 1'b1;
        @(negedge Clock)
        CRD <= 1'b0;
        Add <= 1'b0;
        Drop <= 1'b1;
    end
$vcdplusoff;
$finish;

end

endmodule
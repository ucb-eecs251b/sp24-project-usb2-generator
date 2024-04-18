`timescale 1 ns /  1 ps

module dr_tb();

reg data_in, reset, clock_480, clock_240;
wire data_out;

// Generate 480 MHz clock
initial clock_480 = 1;
always #(`CLOCK_PERIOD/2) clock_480 <= ~clock_480;

// Generate 240 MHz clock
initial clock_240 = 1;
always #(`CLOCK_PERIOD) clock_240 <= ~clock_240;


// Initialize DUT
dr_toplevel dut
(
    .data_in(data_in),
    .reset(reset),
    .clock_480(clock_480),
    .clock_240(clock_240),
    .data_out(data_out)
);

initial begin

$vcdpluson;
    // Reset protocol
    reset <= 1'b1;
    repeat (2) @(negedge clock_480)
    reset <= 1'b0;

    repeat (`FIFO_SIZE) begin // fill entire FIFO with 0,1,0,1...
        @(negedge clock_480)
        data_in <= 1'b0;
        @(negedge clock_480)
        data_in <= 1'b1;
    end
$vcdplusoff;
$finish;

end

endmodule
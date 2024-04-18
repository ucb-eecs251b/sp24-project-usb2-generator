module dr_toplevel
(
    input data_in, reset, clock_480, clock_240,
    output data_out
);

wire VDD = 1'b1;
wire GND = 1'b0;
wire [9:0] clock_x10;

data_recovery dr(
    .data_in(data_in),
    .reset(reset),
    .clock_480(clock_480),
    .clock_240(clock_x10),
    .data_out(data_out),
    .VDD(VDD),
    .GND(GND)
);

clock_gen_x10 ten_phase_clk(
    .clock(clock_240),
    .reset(reset),
    .clock_x10(clock_x10)
);
module dr_toplevel
(
    input data_in, reset, clock_480, clock_5x,
    output data_out
);

//wire VDD = 1'b1;
//wire GND = 1'b0;
wire [9:0] clock_x10;

data_recovery dr(
    .data_in(data_in),
    .reset(reset),
    .clock_480(clock_480),
    .clock_0(clock_x10[0]),
    .clock_1(clock_x10[1]),
    .clock_2(clock_x10[2]),
    .clock_3(clock_x10[3]),
    .clock_4(clock_x10[4]),
    .clock_5(clock_x10[5]),
    .clock_6(clock_x10[6]),
    .clock_7(clock_x10[7]),
    .clock_8(clock_x10[8]),
    .clock_9(clock_x10[9]),
    .data_out(data_out)
    //,
    //.VDD(VDD),
    //.GND(GND)
);

clock_gen_x10 ten_phase_clk(
    .clock(clock_5x),
    .reset(reset),
    .clock_x10(clock_x10)
);
endmodule
module data_recovery
(
    input data_in, clock_480, reset,
    input clock_0,
    input clock_1,
    input clock_2,
    input clock_3,
    input clock_4,
    input clock_5,
    input clock_6,
    input clock_7,
    input clock_8,
    input clock_9,
    output data_out
    //,
    //inout VDD, GND
);

wire [4:0] dout_sampler;
wire dout_crd, add_crd, drop_crd;
wire fifo_underflow, fifo_overflow;

// Initialize sampler
sampler sampler(
    .Din(data_in),
    .clock_0(clock_0),
    .clock_1(clock_1),
    .clock_2(clock_2),
    .clock_3(clock_3),
    .clock_4(clock_4),
    .clock_5(clock_5),
    .clock_6(clock_6),
    .clock_7(clock_7),
    .clock_8(clock_8),
    .clock_9(clock_9),
    .Dout(dout_sampler)
    //,
    //.VDD(VDD),
    //.GND(GND)
);

// Initialize CDR
CRD crd(
    .clock(clock_480),
    .reset(reset),
    .data(dout_sampler),
    .CRD(dout_crd),
    .ADD(add_crd),
    .DROP(drop_crd)
);

// Initialize AD-FIFO
ad_fifo #(.N(41)) fifo  
(
    .CRD(dout_crd),
    .Add(add_crd),
    .Drop(drop_crd),
    .Clock(clock_480),
    .Reset(reset),
    .Underflow(fifo_underflow),
    .Overflow(fifo_overflow),
    .Data(data_out)
);

endmodule
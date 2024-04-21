module data_recovery
(
    input data_in, clock_480, reset,
    input [9:0] clock_x10,
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
    .clock(clock_x10),
    .Dout(data_out)
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
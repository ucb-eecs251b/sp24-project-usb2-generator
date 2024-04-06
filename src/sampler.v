module Sampler(
    input [4:0] clock, // A fixed 480MHz
    input reset,
    input data_in,
    output reg [4:0] data_out
);

always @(posedge clock[0]) begin
    if (reset) data_out[0] <= 1'b0;
    else data_out[0] <= data_in;
end

always @(posedge clock[1]) begin
    if (reset) data_out[1] <= 1'b0;
    else data_out[1] <= data_in;
end

always @(posedge clock[2]) begin
    if (reset) data_out[2] <= 1'b0;
    else data_out[2] <= data_in;
end

always @(posedge clock[3]) begin
    if (reset) data_out[3] <= 1'b0;
    else data_out[3] <= data_in;
end

always @(posedge clock[4]) begin
    if (reset) data_out[4] <= 1'b0;
    else data_out[4] <= data_in;
end

endmodule



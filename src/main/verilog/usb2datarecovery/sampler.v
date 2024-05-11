module Sampler(
    input clock_0,
    input clock_1,
    input clock_2,
    input clock_3,
    input clock_4,
    input reset,
    input data_in,
    output reg [4:0] data
);
reg [4:0] data_out;
always @(posedge clock_0) begin
    if (reset) data_out[0] <= 1'b0;
    else data_out[0] <= data_in;
end

always @(posedge clock_1) begin
    if (reset) data_out[1] <= 1'b0;
    else data_out[1] <= data_in;
end

always @(posedge clock_2) begin
    if (reset) begin
        data_out[2] <= 1'b0;
        data <= 5'b0;
    end
    else begin
        data_out[2] <= data_in;
        data <= data_out;
    end
end

always @(posedge clock_3) begin
    if (reset) data_out[3] <= 1'b0;
    else data_out[3] <= data_in;
end

always @(posedge clock_4) begin
    if (reset) data_out[4] <= 1'b0;
    else data_out[4] <= data_in;
end

endmodule



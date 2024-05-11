`timescale 100 ps /  1 ps

module CRD_SAM_tb();

reg [4:0] clock;
wire CRD, ADD, DROP;
reg reset, data_in;
wire [4:0] data;



initial clock = 5'b0;
always #(10) clock[4] <= ~clock[4]; 
always @(posedge clock[4]) begin
    #4 clock[3] <= ~clock[3];
    #10 clock[3] <= ~clock[3];
end
always @(posedge clock[3]) begin
    #4 clock[2] <= ~clock[2];
    #10 clock[2] <= ~clock[2];
end
always @(posedge clock[2]) begin
    #4 clock[1] <= ~clock[1];
    #10 clock[1] <= ~clock[1];
end
always @(posedge clock[1]) begin
    #4 clock[0] <= ~clock[0];
    #10 clock[0] <= ~clock[0];
end

    // clock period ~2ns
// always #(`CLOCK_PERIOD/2) clock <= ~clock;

// clock_gen dut_clock ( .clock(clock_10x), .reset(reset), .clock_x5(clock_out));

CRD dut ( .clock(clock[0]), .reset(reset), .data(data), .CRD(CRD), .ADD(ADD), .DROP(DROP) );
Sampler dut_sam ( .clock(clock), .reset(reset), .data_in(data_in), .data(data) );
initial begin

$vcdpluson;

 reset <= 1'b1;
 @(negedge clock[0]) 
 @(posedge clock[0]) reset <= 1'b0;
  data_in <= 1'b1;
  #(30) data_in <= 1'b0;
  #(24) data_in <= 1'b1;
  #(24) data_in <= 1'b0;
  #(8)  data_in <= 1'b1;
repeat (5) @(posedge clock);


$vcdplusoff;
$finish;

end


endmodule
`timescale 100 ps /  1 ps

module CRD_tb();

reg [4:0] clock;
wire CRD, ADD, DROP;
reg reset, data_in;
wire [4:0] data;

initial clock = 5'b0;
always #(10) begin
    clock[0] <= ~clock[0]; 
    #(2) clock[1] <= ~clock[1]; 
    #(4) clock[2] <= ~clock[2]; 
    #(6) clock[3] <= ~clock[3]; 
    #(8) clock[4] <= ~clock[4]; 
end
    // clock period ~2ns
// always #(`CLOCK_PERIOD/2) clock <= ~clock;


CRD dut ( .clock(clock[0]), .reset(reset), .data(data), .CRD(CRD), .ADD(ADD), .DROP(DROP) );
Sampler dut_sam ( .clock(clock), .reset(reset), .data_in(data_in), .data_out(data) );
initial begin

$vcdpluson;

 reset <= 1'b1;
 @(negedge clock) reset <= 1'b0;
  data <= 5'b00000;
 @(negedge clock)  data<= 5'b11111;
 @(negedge clock)  data<= 5'b00011;
 repeat(5) @(negedge clock) ;
 @(negedge clock)  data<= 5'b00111;
 repeat (5) @(negedge clock) ;
 @(negedge clock)  data<= 5'b01111;
 @(negedge clock)  data<= 5'b00001;
 @(negedge clock)  data<= 5'b00001;

$vcdplusoff;
$finish;

end


endmodule
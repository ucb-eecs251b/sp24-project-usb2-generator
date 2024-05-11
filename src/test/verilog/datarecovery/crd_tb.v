`timescale 100 ps /  1 ps

module CRD_tb();

reg [4:0] data;
wire CRD, ADD, DROP;
reg reset, clock;

initial clock = 0;
always #(10) begin
    clock <= ~clock; 
end
    // clock period ~2ns
// always #(`CLOCK_PERIOD/2) clock <= ~clock;


CRD dut ( .clock(clock), .reset(reset), .data(data), .CRD(CRD), .ADD(ADD), .DROP(DROP) );
initial begin

$vcdpluson;

 reset <= 1'b1;
 @(negedge clock) reset <= 1'b0;
  data <= 5'b00000;
  // ===== TEST 1 =====
  // Case 1
 @(negedge clock)
 @(posedge clock)  data<= 5'b11111;
  // Case 3
 @(posedge clock)  data<= 5'b11000;
  // Case 4
 @(posedge clock)  data<= 5'b00011;
  // Case 5
 @(posedge clock)  data<= 5'b11110;
  // Case 2
 @(posedge clock)  data<= 5'b01111;
  // Case 0
 @(posedge clock)  data<= 5'b11111;
 repeat (5) @(posedge clock);

 // ===== TEST 2 =====
  // Case 1
@(posedge clock)  data<= 5'b00001;
  // Case 5
 @(posedge clock)  data<= 5'b11111;
  // Case 1
 @(posedge clock)  data<= 5'b00000;
  // Case 5
 @(posedge clock)  data<= 5'b00001;
  // Case 5
 @(posedge clock)  data<= 5'b11110;
  // Case 0
 @(posedge clock)  data<= 5'b00000;
 repeat (5) @(posedge clock);


$vcdplusoff;
$finish;

end


endmodule
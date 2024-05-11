`timescale 1 ns /  1 fs

module dr_tb();

parameter TESTCASE = 8192;
reg data_in, reset, clock_Rx, clock_10x, clock_Tx, enable_Tx;
wire data_out;
reg [TESTCASE-1:0] data_in_buffer, data_out_buffer;

real OFFSET; // offset of Tx clock period in ns. 1000ppm = 0.1% = 0.002ns
integer DIN_BUFFER_WAIT;
integer DOUT_BUFFER_WAIT;
integer SCALE = 1;

reg random_bit;


// Generate 480 MHz clock for Rx
initial clock_Rx = 1;
always #(`CLOCK_PERIOD / 2) clock_Rx <= ~clock_Rx;

// Generate 2.4 GHz clock for 10 phase clock generator
initial clock_10x = 1;
always #(`CLOCK_PERIOD / 20) clock_10x <= ~clock_10x;

initial reset <= 1;
// Generate Tx clock. Defaults to 480 MHz but period is adjusted with variable OFFSET
initial begin
    OFFSET = 0.0;  // Starting OFFSET = 0ns so Tx = Rx
    clock_Tx = 1;
    enable_Tx = 1; // Enable clock toggling initially
    forever begin
        if (enable_Tx) begin
            #((`CLOCK_PERIOD / 2) + OFFSET/2) clock_Tx = ~clock_Tx;
        end
        else begin
            clock_Tx = 0;
            @(posedge enable_Tx);  // Wait for enable signal to toggle clock
        end
    end
end


// Initialize DUT
dr_toplevel dut
(
    .data_in(data_in),
    .reset(reset),
    .clock_480(clock_Rx),
    .clock_5x(clock_10x),
    .data_out(data_out)
);


integer i;
always begin
    data_in <= 0;
    data_in_buffer <= {TESTCASE-1{1'bx}};
    for(i=0; i<=(TESTCASE); i=i+1) begin
        @(posedge clock_Tx)
        data_in <= $urandom_range(0, 1);  // Uniformly random 0 or 1
        data_in_buffer <= {data_in_buffer[TESTCASE-2:0], data_in};
    end
    repeat(DIN_BUFFER_WAIT) @(posedge clock_Tx);
end
integer j;
always begin
    data_out_buffer <= {TESTCASE-1{1'bx}};
    for(j=0; j<=(TESTCASE+DOUT_BUFFER_WAIT); j=j+1) begin
        @(posedge clock_Rx)
        data_out_buffer <= {data_out_buffer[TESTCASE-2:0], data_out};
    end
    repeat(1) @(posedge clock_Rx);

end

integer k;
// Clock generation block with dynamic OFFSET
initial begin
$vcdpluson;
    // Test 1: Tx same as Rx
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.0;
    DIN_BUFFER_WAIT = 28;
    DOUT_BUFFER_WAIT = 29;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE+27) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 1 PASSED! #####");
    else $display("Mismatch detected in TEST 1 ><");

    // Test 2: Tx slower than Rx by +1000ppm = 0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.004;
    DIN_BUFFER_WAIT = 28;
    DOUT_BUFFER_WAIT = 29;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE+28) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 2 PASSED! #####");
    else $display("Mismatch detected in TEST 2 ><");

    // Test 3: Tx faster than Rx by -1000ppm = -0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = -0.004;
    DIN_BUFFER_WAIT = 43;
    DOUT_BUFFER_WAIT = 40;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE+44) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 3 PASSED! #####");
    else $display("Mismatch detected in TEST 3 ><");

    // Test 4: Tx jitters relative to Rx at +/-1000ppm = +/-0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.0;
    DIN_BUFFER_WAIT = 28;
    DOUT_BUFFER_WAIT = 29;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE) @(negedge clock_Tx) OFFSET = real'($bits($urandom_range(-2, 2)) / 1000);

    repeat(29) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 4 PASSED! #####");
    else $display("Mismatch detected in TEST 4 ><");

    // Test 5: Tx jitters relative to Rx by +/-1000ppm = 0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.0;
    DIN_BUFFER_WAIT = 28;
    DOUT_BUFFER_WAIT = 29;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE/512) begin
        random_bit = $urandom_range(0, 1); // Generate a random bit (0 or 1)
        repeat(512) begin
            @(negedge clock_Tx) OFFSET = (random_bit == 0) ? 0.004 : -0.004; // Assign +0.004 if random_bit is 0, otherwise assign -0.004
        end
    end

    OFFSET = 0.0;
    repeat(27) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 5 PASSED! #####");
    else $display("Mismatch detected in TEST 5 ><");

    reset <= 1'b1;
    @(negedge clock_Rx);

$vcdplusoff;
$finish;
end

endmodule
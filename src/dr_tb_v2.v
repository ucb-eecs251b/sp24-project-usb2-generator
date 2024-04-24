`timescale 1 ns /  1 fs

module dr_tb();

parameter TESTCASE = 500;
reg data_in, reset, clock_Rx, clock_10x, clock_Tx, enable_Tx;
wire data_out;
reg [TESTCASE-1:0] data_in_buffer, data_out_buffer;

real OFFSET; // offset of Tx clock period in ns. 1000ppm = 0.1% = 0.002ns


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


// integer i;
// always begin
//     if(reset) begin
//         data_in <= 0;
//         data_in_buffer <= {TESTCASE-1{1'bx}};
//     end
//     else begin
//         for(i=0; i<=TESTCASE; i=i+1) begin
//             @(posedge clock_Tx)
//             data_in <= $urandom_range(0, 1);  // Uniformly random 0 or 1
//             data_in_buffer <= {data_in_buffer[TESTCASE-2:0], data_in};
//         end
//         repeat(25) @(posedge clock_Tx);
//     end
// end
// integer j;
// always begin
//     if(reset) data_out_buffer <= {TESTCASE-1{1'bx}};
//     else begin
//         for(j=0; j<=(TESTCASE+26); j=j+1) begin
//             @(posedge clock_Rx)
//             data_out_buffer <= {data_out_buffer[TESTCASE-2:0], data_out};
//         end
//         repeat(2) @(posedge clock_Rx);
//     end
// end
integer i;
always begin
    data_in <= 0;
    data_in_buffer <= {TESTCASE-1{1'bx}};
    for(i=0; i<=TESTCASE; i=i+1) begin
        @(posedge clock_Tx)
        data_in <= $urandom_range(0, 1);  // Uniformly random 0 or 1
        data_in_buffer <= {data_in_buffer[TESTCASE-2:0], data_in};
    end
    repeat(27) @(posedge clock_Tx);
end
integer j;
always begin
    data_out_buffer <= {TESTCASE-1{1'bx}};
    for(j=0; j<=(TESTCASE+28); j=j+1) begin
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
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE+26) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 1 PASSED! #####");
    else $display("Mismatch detected in TEST 1 ><");

    // Test 2: Tx slower than Rx by +1000ppm = 0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.004;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE+27) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 2 PASSED! #####");
    else $display("Mismatch detected in TEST 2 ><");

    // Test 3: Tx faster than Rx by -1000ppm = -0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = -0.004;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat(TESTCASE+29) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 3 PASSED! #####");
    else $display("Mismatch detected in TEST 3 ><");

    // Test 4: Tx jitters relative to Rx at +/-1000ppm = +/-0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.0;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;



    repeat(TESTCASE) @(negedge clock_Tx) OFFSET = real'($bits($urandom_range(-2, 2)) / 1000);

    // for (k = 0; k < TESTCASE; k=k+1) begin
    //     OFFSET <= $urandom_range(-2, 2) / 1000;  // Convert from ps to ns
    // end

    repeat(27) @(negedge clock_Rx);

    if(data_in_buffer === data_out_buffer) $display("##### TEST 4 PASSED! #####");
    else $display("Mismatch detected in TEST 4 ><");

    @(negedge clock_Rx);
    reset <= 1'b1;
    @(negedge clock_Rx);

$vcdplusoff;
$finish;
end

endmodule
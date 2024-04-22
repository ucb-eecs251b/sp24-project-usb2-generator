`timescale 1 ns /  1 ps

module dr_tb();

reg data_in, reset, clock_Rx, clock_10x, clock_Tx, enable_Tx;
wire data_out;
reg [19:0] data_in_buffer;

real OFFSET; // offset of Tx clock period in ns. 1000ppm = 0.1% = 0.002ns

// Generate 480 MHz clock for Rx
initial clock_Rx = 1;
always #(`CLOCK_PERIOD / 2) clock_Rx <= ~clock_Rx;

// Generate 2.4 GHz clock for 10 phase clock generator
initial clock_10x = 1;
always #(`CLOCK_PERIOD / 20) clock_10x <= ~clock_10x;

// Generate Tx clock. Defaults to 480 MHz but period is adjusted with variable OFFSET
initial begin
    OFFSET = 0.0;  // Starting OFFSET = 0ns so Tx = Rx
    clock_Tx = 1;
    enable_Tx = 1; // Enable clock toggling initially
    forever begin
        if (enable_Tx) begin
            #((`CLOCK_PERIOD / 2) + OFFSET) clock_Tx = ~clock_Tx;
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

// Clock generation block with dynamic OFFSET
initial begin
$vcdpluson;
    // Test 1: Tx same as Rx
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.0;
    data_in_buffer = 20'bx;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat (100) begin
        @(negedge clock_Tx)
        data_in <= $urandom_range(0, 1);  // Uniformly random 0 or 1

        data_in_buffer <= {data_in_buffer[18:0], data_in};
        if (reset === 1'b0 && data_out !== 1'bx) begin
            assert(data_in_buffer[19] === data_out) else $display("Mismatch detected at time %t", $time);
        end
    end

    // Test 2: Tx slower than Rx by +1000ppm = 0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.002;
    data_in_buffer = 20'bx;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat (100) begin
        @(negedge clock_Tx)
        data_in <= $urandom_range(0, 1);  // Uniformly random 0 or 1

        data_in_buffer <= {data_in_buffer[18:0], data_in};
        if (reset === 1'b0 && data_out !== 1'bx) begin
            assert(data_in_buffer[19] === data_out) else $display("Mismatch detected at time %t", $time);
        end
    end

    // Test 3: Tx faster than Rx by -1000ppm = -0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = -0.002;
    data_in_buffer = 20'bx;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    repeat (100) begin
        @(negedge clock_Tx)
        data_in <= $urandom_range(0, 1);  // Uniformly random 0 or 1

        data_in_buffer <= {data_in_buffer[18:0], data_in};
        if (reset === 1'b0 && data_out !== 1'bx) begin
            assert(data_in_buffer[19] === data_out) else $display("Mismatch detected at time %t", $time);
        end
    end

    // Test 4: Tx jitters relative to Rx at +/-1000ppm = +/-0.002ns
    // Reset protocol
    reset <= 1'b1;
    enable_Tx <= 0;
    OFFSET = 0.0;
    data_in_buffer = 20'bx;
    repeat(2) @(negedge clock_Rx);
    reset <= 1'b0;
    enable_Tx <= 1;

    // for (int i = 0; i < 100; i=i+1) begin
    //     OFFSET = $urandom_range(-2, 2) / 1000;  // Convert from ps to ns
    //     @(negedge clock_Tx)
    //     data_in <= $urandom_range(0, 1);  // Uniformly random 0 or 1
    // end

$vcdplusoff;
$finish;
end

endmodule
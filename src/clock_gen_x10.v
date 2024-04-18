module clock_gen_x10(
    input clock,
    input reset,
    output reg [9:0] clock_x10  // Now using a 10-bit output for the ten clocks
);

reg [3:0] counter;
always @(posedge clock) begin
    if (reset) begin
        counter <= 4'd9;  // We still use a 10-state counter
        clock_x10 <= 10'b0000000000;  // Reset all outputs
    end
    else begin
        counter <= (counter == 4'd0) ? 4'd9 : counter - 1;
        // Each line below toggles a different clock phase
        clock_x10[0] <= (counter == 4'd9) ? ~clock_x10[0] : clock_x10[0];  // 0% phase shift
        clock_x10[1] <= (counter == 4'd8) ? ~clock_x10[1] : clock_x10[1];  // 10% phase shift
        clock_x10[2] <= (counter == 4'd7) ? ~clock_x10[2] : clock_x10[2];  // 20% phase shift
        clock_x10[3] <= (counter == 4'd6) ? ~clock_x10[3] : clock_x10[3];  // 30% phase shift
        clock_x10[4] <= (counter == 4'd5) ? ~clock_x10[4] : clock_x10[4];  // 40% phase shift
        clock_x10[5] <= (counter == 4'd4) ? ~clock_x10[5] : clock_x10[5];  // 50% phase shift
        clock_x10[6] <= (counter == 4'd3) ? ~clock_x10[6] : clock_x10[6];  // 60% phase shift
        clock_x10[7] <= (counter == 4'd2) ? ~clock_x10[7] : clock_x10[7];  // 70% phase shift
        clock_x10[8] <= (counter == 4'd1) ? ~clock_x10[8] : clock_x10[8];  // 80% phase shift
        clock_x10[9] <= (counter == 4'd0) ? ~clock_x10[9] : clock_x10[9];  // 90% phase shift
    end
end
endmodule

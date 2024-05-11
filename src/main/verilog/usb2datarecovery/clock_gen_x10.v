module clock_gen_x10(
    input clock,
    input reset,
    output reg [9:0] clock_x10  // Now using a 10-bit output for the ten clocks
);

reg [4:0] counter;
always @(posedge clock) begin
    if (reset) begin
        counter <= 5'd19;  // We still use a 10-state counter
        clock_x10 <= 10'b0000000000;  // Reset all outputs
    end
    else begin
        counter <= (counter == 5'd0) ? 5'd19 : counter - 1;
        // Each line below toggles a different clock phase
        clock_x10[0] <= (counter == 5'd15 || (counter == 5'd5 & clock_x10[0] == 1'b1)) ? ~clock_x10[0] : clock_x10[0];  // 0% phase shift
        clock_x10[1] <= (counter == 5'd13 || (counter == 5'd3 & clock_x10[1] == 1'b1)) ? ~clock_x10[1] : clock_x10[1];  // 10% phase shift
        clock_x10[2] <= (counter == 5'd11 || (counter == 5'd1 & clock_x10[2] == 1'b1)) ? ~clock_x10[2] : clock_x10[2];  // 20% phase shift
        clock_x10[3] <= (counter == 5'd9 || (counter == 5'd19 & clock_x10[3] == 1'b1)) ? ~clock_x10[3] : clock_x10[3];  // 30% phase shift
        clock_x10[4] <= (counter == 5'd7 || (counter == 5'd17 & clock_x10[4] == 1'b1)) ? ~clock_x10[4] : clock_x10[4];  // 40% phase shift
        clock_x10[5] <= (counter == 5'd5 || (counter == 5'd15 & clock_x10[5] == 1'b1)) ? ~clock_x10[5] : clock_x10[5];  // 50% phase shift
        clock_x10[6] <= (counter == 5'd3 || (counter == 5'd13 & clock_x10[6] == 1'b1)) ? ~clock_x10[6] : clock_x10[6];  // 60% phase shift
        clock_x10[7] <= (counter == 5'd1 || (counter == 5'd11 & clock_x10[7] == 1'b1)) ? ~clock_x10[7] : clock_x10[7];  // 70% phase shift
        clock_x10[8] <= (counter == 5'd19 || (counter == 5'd9 & clock_x10[8] == 1'b1)) ? ~clock_x10[8] : clock_x10[8];  // 80% phase shift
        clock_x10[9] <= (counter == 5'd17 || (counter == 5'd7 & clock_x10[9] == 1'b1)) ? ~clock_x10[9] : clock_x10[9];  // 90% phase shift
    end
end
endmodule

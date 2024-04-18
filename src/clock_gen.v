module clock_gen(
    input clock,
    input reset,
    output [4:0] clock_x5
);

reg [3:0] counter;
always @(posedge clock) begin
    if(reset) begin
        counter <= 4'd10;
        clock_x5 <= 5'b0;
    end
    else begin
        counter <= (counter == 4'd0) ? 4'd9: counter - 1;
        clock_x5[0] <= (counter == 4'd9) ? ~clock_x5[0]: clock_x5[0];
        clock_x5[4] <= (counter == 4'd7) ? ~clock_x5[4]: clock_x5[4];
        clock_x5[3] <= (counter == 4'd5) ? ~clock_x5[3]: clock_x5[3];
        clock_x5[2] <= (counter == 4'd3) ? ~clock_x5[2]: clock_x5[2];
        clock_x5[1] <= (counter == 4'd1) ? ~clock_x5[1]: clock_x5[1];
    end
end
endmodule

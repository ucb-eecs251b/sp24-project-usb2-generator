module token_control
(
    input clk, reset, add_left, drop_left, ptr_left, ptl_right,
    output add_right, drop_right, ptr_right, ptl_left, token
);

// create 4 internal registers
reg add_d, add_q;
reg drop_d, drop_q;
reg dff1_d, dff1_q;
reg dff2_d, dff2_q;

// structural verilog logic block
assign add_left = add_d;
assign add_right = add_q;

assign drop_left = drop_d;
assign drop_right = drop_q;

assign dff1_d = add_left & (dff2_q | ptl_right);
assign dff2_d = ((ptl_right & !add_left) | (!add_left & !drop_left & dff2_q) | (ptr_left));
assign ptl_left = dff2_q & drop_left;
assign ptr_right = dff1_q;
assign token = dff1_q | dff2_q;

// active high reset for registers and combinational control
always @(posedge clk) begin
    if (reset) begin
        add_q <= 0;
        drop_q <= 0;
        dff1_q <= 0;
        dff2_q <= 0;
    end else begin
        add_q <= add_d;
        drop_q <= drop_d;
        dff1_q <= dff1_d;
        dff2_q <= dff2_d;
    end
end

endmodule
module token_control
(
    input clk, reset, add_left, drop_left, ptr_left, ptl_right,
    output reg add_right, drop_right, ptr_right, ptl_left, token,
    input has_token_rst
);

reg add_d, add_q;
reg drop_d, drop_q;
reg ptr_d, ptr_q;
reg ptl_d, ptl_q;
reg has_token_d, has_token_q;

assign add_d = add_left;
assign add_right = add_q;
assign drop_d = drop_left;
assign drop_right = drop_q;
assign ptr_right = ptr_q;
// assign ptl_left = ptl_q;

assign token = has_token_q | ptr_q;

// pass token right on next cycle if adding and cell has the token
always @* begin
    if ((has_token_q | ptl_right) & add_left) begin
        ptr_d = 1'b1;
    end else begin
        ptr_d = 1'b0;
    end
end

// pass token left on next cycle if dropping and cell has token
always @* begin
    if (has_token_q & drop_left) begin
        ptl_left = 1'b1;
    end else begin
        ptl_left = 1'b0;
    end
end

// cell token logic
always @* begin
    if ((has_token_q & !add_left & !drop_left) | (ptl_right & !add_d) | ptr_left) begin
        has_token_d = 1'b1;
    end else begin
        has_token_d = 1'b0;
    end
end

// active high reset for registers and combinational control
always @(posedge clk) begin
    if (reset) begin
        add_q <= 0;
        drop_q <= 0;
        ptr_q <= 0;
        //ptl_q <= 0;
        has_token_q <= has_token_rst;
    end else begin
        add_q <= add_d;
        drop_q <= drop_d;
        ptr_q <= ptr_d;
        //ptl_q <= ptl_d;
        has_token_q <= has_token_d;
    end
end

endmodule

// module token_control
// (
//     input clk, reset, add_left, drop_left, ptr_left, ptl_right,
//     output add_right, drop_right, ptr_right, ptl_left, token,
//     input has_token_rst
// );

// // create 4 internal registers
// reg add_d, add_q;
// reg drop_d, drop_q;
// reg dff1_d, dff1_q;
// reg dff2_d, dff2_q;

// // structural verilog logic block
// assign add_d = add_left;
// assign add_right = add_q;

// assign drop_d = drop_left;
// assign drop_right = drop_q;

// assign dff1_d = add_left & (dff2_q | ptl_right);
// assign dff2_d = ((ptl_right & !add_left) | (!add_left & !drop_left & dff2_q) | (ptr_left));
// assign ptl_left = dff2_q & drop_left;
// assign ptr_right = dff1_q;
// assign token = dff1_q | dff2_q;

// // active high reset for registers and combinational control
// always @(posedge clk) begin
//     if (reset) begin
//         add_q <= 0;
//         drop_q <= 0;
//         dff1_q <= 0;
//         dff2_q <= has_token_rst;
//     end else begin
//         add_q <= add_d;
//         drop_q <= drop_d;
//         dff1_q <= dff1_d;
//         dff2_q <= dff2_d;
//     end
// end

// endmodule
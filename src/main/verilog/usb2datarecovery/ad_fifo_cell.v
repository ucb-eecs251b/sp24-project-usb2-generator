module ad_fifo_cell
(
    input crd_left, add_left, drop_left, ptr_left, ptl_right, clk, reset,
    output crd_right, add_right, drop_right, ptr_right, ptl_left, token_out,
    output reg cell_output,
    input has_token_rst
);

// create internal wires
wire token;

// create internal registers
reg crd_d, crd_q;

assign crd_d = crd_left;
assign crd_right = crd_q;
assign token_out = token;

// instantiate and token control module
token_control TC(
    .clk(clk),
    .reset(reset),
    .add_left(add_left),
    .drop_left(drop_left),
    .ptr_left(ptr_left),
    .ptl_right(ptl_right),
    .add_right(add_right),
    .drop_right(drop_right),
    .ptr_right(ptr_right),
    .ptl_left(ptl_left),
    .token(token),
    .has_token_rst(has_token_rst)
);

always @* begin
    if (token == 1'b1) begin        // AD-FIFO cell has token and is in output mode
        if (ptr_right == 1'b0) begin
            cell_output = crd_q;    // cell outputs its stored value
        end else begin
            cell_output = !crd_q;   // cell adds missing value by inverting stored value
        end
    end else begin                  // AD-FIFO cell does not have token and is in high Z mode
        cell_output = 1'bz;
    end
end

always @(posedge clk) begin
    if (reset) begin
        crd_q <= 0;
    end else begin
        crd_q <= crd_d;
    end
end

endmodule



// Define signal AD-FIFO cell module
// module ad_fifo_cell
// (
//     input crd_left, add_left, drop_left, ptr_left, ptl_right, clk, reset,
//     output crd_right, add_right, drop_right, ptr_right, ptl_left, token,
//     output reg cell_output,
//     input has_token_rst
// );
// endmodule

module ad_fifo #(parameter N = 41) // AD-FIFO size is 2N+1 = 41
(
    input CRD, Add, Drop, Clock, Reset,
    output Underflow, Overflow, Data
);

// Define wires to connect the FIFO
wire [N:0] crd, add, drop, ptr, ptl;
wire clk, reset, cell_output;
wire [N-1:0] has_token_rst, token_out;

// Assign AD-FIFO I/O
// inputs
assign crd[0] = CRD;
assign add[0] = Add;
assign drop[0] = Drop;
assign clk = Clock;
assign reset = Reset;
// outputs
assign Underflow = ptl[0];
assign Overflow = ptr[N];
assign Data = cell_output;

assign has_token_rst = {{(N/2){1'b0}}, 1'b1, {(N/2){1'b0}}};

// Generate 2N+1 copies of the cell module
genvar i;
generate
    for (i=0; i<N; i=i+1) begin : cell_instance
        ad_fifo_cell cell_inst (
            .crd_left(crd[i]),
            .add_left(add[i]),
            .drop_left(drop[i]),
            .ptr_left(ptr[i]),
            .ptl_right(ptl[i+1]),
            .clk(clk),
            .reset(reset),
            .crd_right(crd[i+1]),
            .add_right(add[i+1]),
            .drop_right(drop[i+1]),
            .ptr_right(ptr[i+1]),
            .ptl_left(ptl[i]),
            .cell_output(cell_output),
            .has_token_rst(has_token_rst[i]),
            .token_out(token_out[i])
        );
    end
endgenerate

endmodule


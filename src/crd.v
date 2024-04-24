module CRD(
    input clock,
    input reset,
    input [4:0] data,
    output CRD,
    output ADD,
    output DROP
);

reg [4:0] data_r, data_w, data_2_r, data_2_w;
reg [4:0] flag_r, flag_w;
reg [2:0] ctrl_r, ctrl_w;
reg ADD_r, ADD_w, DROP_r, DROP_w;

assign CRD = data_2_r[ctrl_r];
assign ADD = ADD_r;
assign DROP = DROP_r;

// ===== Combinational Logics =====
always @(*) begin // transition detector; flag
    data_w = data;
    data_2_w = data_r;
    flag_w = (data_w == data_r) ? flag_r: data_w ^ {5{data_r[4]}};
end
always @(*) begin // phase detector; ctrl
    if (flag_r[0] == 1'b1) ctrl_w = 3'b010; // Case 1; P2
    else if (flag_r[1] == 1'b1) ctrl_w = 3'b011; // Case 2; P3
    else if (flag_r[2] == 1'b1) ctrl_w = 3'b100; // Case 3; P4
    else if (flag_r[3] == 1'b1) ctrl_w = 3'b000; // Case 4; P0
    else if (flag_r[4] == 1'b1) ctrl_w = 3'b001; // Case 5; P1
    else ctrl_w = ctrl_r;  // Case 0; remain
end
always @(*) begin // output
    if( (ctrl_r[1] == ctrl_w[1]) && (ctrl_r[0] == ctrl_w[0]) && (ctrl_r[2] != ctrl_w[2]) ) begin
        ADD_w = !ctrl_r[2];
        DROP_w = ctrl_r[2];
    end
    else begin
        ADD_w = 1'b0;
        DROP_w = 1'b0;
    end
end
// ===== Sequential Logics =====
always @(posedge clock) begin
    if(reset) begin
        data_r <= 5'b0;
        data_2_r <= 5'b0;
        flag_r <= 5'b0;
        ctrl_r <= 3'b0;
        ADD_r  <= 1'b0;
        DROP_r <= 1'b0;
    end
    else begin
        data_r <= data_w;
        data_2_r <= data_2_w;
        flag_r <= flag_w;
        ctrl_r <= ctrl_w;
        ADD_r  <= ADD_w;
        DROP_r <= DROP_w;
    end
end
endmodule

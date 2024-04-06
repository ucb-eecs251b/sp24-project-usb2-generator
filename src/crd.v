module CRD(
    input clock,
    input reset,
    input [4:0] data,
    output CRD,
    output ADD,
    output DROP
);

reg [4:0] data_r, data_w;
reg [4:0] flag_r, flag_w;
reg [2:0] ctrl_r, ctrl_w;

assign CRD = data[ctrl_w];
assign ADD = (flag_w == 5'b00000)? 1'b0: (!flag_r[2] && flag_w[2]);
assign DROP = (flag_w == 5'b00000)? 1'b0: (flag_r[2] && !flag_w[2]);

// ===== Combinational Logics =====
always @(*) begin // transition detector; flag
    data_w = data;
    flag_w = data_w ^ {5{data_r[0]}};
end
always @(*) begin // phase detector; ctrl
    case(flag_w)
        5'b11111: ctrl_w = 3'b010;
        5'b11110: ctrl_w = 3'b001;
        5'b11100: ctrl_w = 3'b000;
        5'b11000: ctrl_w = 3'b100;
        5'b10000: ctrl_w = 3'b011;
        5'b00000: ctrl_w = ctrl_r;
        default: ctrl_w = ctrl_r;
    endcase
end

// ===== Sequential Logics =====
always @(posedge clock) begin
    if(reset) begin
        data_r <= 5'b0;
        flag_r <= 5'b0;
        ctrl_r <= 3'b0;
    end
    else begin
        data_r <= data_w;
        flag_r <= flag_w;
        ctrl_r <= ctrl_w;
    end
end
endmodule

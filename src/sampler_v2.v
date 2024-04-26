// comment for synthesis
//`include "/home/ff/eecs251b/sky130/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
module sampler(
    input Din,
    input clock_0,
    input clock_1,
    input clock_2,
    input clock_3,
    input clock_4,
    input clock_5,
    input clock_6,
    input clock_7,
    input clock_8,
    input clock_9,
    input clock_480,
    output [4:0] Dout
    //,
    //inout VDD,
    //inout GND
);

wire [9:0] Q_sam, Q_sam_2, Q_sam_3;
wire Q_sam_d0, Q_sam_d5;
wire [4:0] Dout_mux;

sky130_fd_sc_hd__dfxtp_2 row0_0 (.Q(Q_sam[0]), .CLK(clock_0), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_1 (.Q(Q_sam[1]), .CLK(clock_1), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_2 (.Q(Q_sam[2]), .CLK(clock_2), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_3 (.Q(Q_sam[3]), .CLK(clock_3), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_4 (.Q(Q_sam[4]), .CLK(clock_4), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

sky130_fd_sc_hd__dfxtp_2 row1_0 (.Q(Q_sam[5]), .CLK(clock_5), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_1 (.Q(Q_sam[6]), .CLK(clock_6), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_2 (.Q(Q_sam[7]), .CLK(clock_7), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_3 (.Q(Q_sam[8]), .CLK(clock_8), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_4 (.Q(Q_sam[9]), .CLK(clock_9), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

inv_delay row0_delay (.Din(Q_sam[0]), .Dout(Q_sam_d0));//, .VDD(VDD), .GND(GND));
inv_delay row1_delay (.Din(Q_sam[5]), .Dout(Q_sam_d5));//, .VDD(VDD), .GND(GND));

assign Q_sam_3[0] = Q_sam_2[0];
assign Q_sam_3[1] = Q_sam_2[1];
assign Q_sam_3[2] = Q_sam_2[2];
assign Q_sam_3[3] = Q_sam_2[3];
assign Q_sam_3[4] = Q_sam_2[4];
assign Q_sam_3[5] = Q_sam_2[5];
assign Q_sam_3[6] = Q_sam_2[6];
assign Q_sam_3[7] = Q_sam_2[7];
assign Q_sam_3[8] = Q_sam_2[8];
assign Q_sam_3[9] = Q_sam_2[9];



sky130_fd_sc_hd__dfxtp_2 row0_02 (.Q(Q_sam_2[0]), .CLK(clock_0), .D(Q_sam_d0));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_12 (.Q(Q_sam_2[1]), .CLK(clock_0), .D(Q_sam[1]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_22 (.Q(Q_sam_2[2]), .CLK(clock_0), .D(Q_sam[2]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_32 (.Q(Q_sam_2[3]), .CLK(clock_0), .D(Q_sam[3]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_42 (.Q(Q_sam_2[4]), .CLK(clock_0), .D(Q_sam[4]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

sky130_fd_sc_hd__dfxtp_2 row1_02 (.Q(Q_sam_2[5]), .CLK(clock_5), .D(Q_sam_d5));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_12 (.Q(Q_sam_2[6]), .CLK(clock_5), .D(Q_sam[6]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_22 (.Q(Q_sam_2[7]), .CLK(clock_5), .D(Q_sam[7]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_32 (.Q(Q_sam_2[8]), .CLK(clock_5), .D(Q_sam[8]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_42 (.Q(Q_sam_2[9]), .CLK(clock_5), .D(Q_sam[9]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

sky130_fd_sc_hd__mux2_1 mux0 (.X(Dout_mux[0]), .A0(Q_sam_3[5]), .A1(Q_sam_3[0]), .S(clock_0));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2_1 mux1 (.X(Dout_mux[1]), .A0(Q_sam_3[6]), .A1(Q_sam_3[1]), .S(clock_0));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2_1 mux2 (.X(Dout_mux[2]), .A0(Q_sam_3[7]), .A1(Q_sam_3[2]), .S(clock_0));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2_1 mux3 (.X(Dout_mux[3]), .A0(Q_sam_3[8]), .A1(Q_sam_3[3]), .S(clock_0));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2_1 mux4 (.X(Dout_mux[4]), .A0(Q_sam_3[9]), .A1(Q_sam_3[4]), .S(clock_0));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

sky130_fd_sc_hd__dfxtp_2 mux_out_0 (.Q(Dout[0]), .CLK(clock_480), .D(Dout_mux[0]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 mux_out_1 (.Q(Dout[1]), .CLK(clock_480), .D(Dout_mux[1]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 mux_out_2 (.Q(Dout[2]), .CLK(clock_480), .D(Dout_mux[2]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 mux_out_3 (.Q(Dout[3]), .CLK(clock_480), .D(Dout_mux[3]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 mux_out_4 (.Q(Dout[4]), .CLK(clock_480), .D(Dout_mux[4]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

endmodule

module inv_delay(
    input Din,
    output reg Dout
    //,
    //inout VDD,
    //inout GND
);
wire [6:0] D;
wire Dout_delay;

// comment this when running post-syn simulation
always @(*) begin
    #0.8 Dout = Dout_delay;
end
//
sky130_fd_sc_hd__bufinv_16 inv1 (.Y(D[0]), .A(Din));//.VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv2 (.Y(D[1]), .A(D[0]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv3 (.Y(D[2]), .A(D[1]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv4 (.Y(D[3]), .A(D[2]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv5 (.Y(D[4]), .A(D[3]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv6 (.Y(D[5]), .A(D[4]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv7 (.Y(D[6]), .A(D[5]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv8 (.Y(Dout_delay), .A(D[6]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

endmodule

`include "/home/ff/eecs251b/sky130/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
module sampler(
    input Din,
    input [9:0] clock,
    output [4:0] Dout
    //,
    //inout VDD,
    //inout GND
);

wire [9:0] Q_sam, Q_sam_2, Q_sam_3;
wire Q_sam_d0, Q_sam_d5;

sky130_fd_sc_hd__dfxtp_2 row0_0 (.Q(Q_sam[0]), .CLK(clock[0]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_1 (.Q(Q_sam[1]), .CLK(clock[1]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_2 (.Q(Q_sam[2]), .CLK(clock[2]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_3 (.Q(Q_sam[3]), .CLK(clock[3]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_4 (.Q(Q_sam[4]), .CLK(clock[4]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

sky130_fd_sc_hd__dfxtp_2 row1_0 (.Q(Q_sam[5]), .CLK(clock[5]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_1 (.Q(Q_sam[6]), .CLK(clock[6]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_2 (.Q(Q_sam[7]), .CLK(clock[7]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_3 (.Q(Q_sam[8]), .CLK(clock[8]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_4 (.Q(Q_sam[9]), .CLK(clock[9]), .D(Din));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

inv_delay row0_delay (.Din(Q_sam[0]), .Dout(Q_sam_d0));//, .VDD(VDD), .GND(GND));
inv_delay row1_delay (.Din(Q_sam[5]), .Dout(Q_sam_d5));//, .VDD(VDD), .GND(GND));
inv_delay mux_delay0 (.Din(Q_sam_2[0]), .Dout(Q_sam_3[0]));
inv_delay mux_delay1 (.Din(Q_sam_2[1]), .Dout(Q_sam_3[1]));
inv_delay mux_delay2 (.Din(Q_sam_2[2]), .Dout(Q_sam_3[2]));
inv_delay mux_delay3 (.Din(Q_sam_2[3]), .Dout(Q_sam_3[3]));
inv_delay mux_delay4 (.Din(Q_sam_2[4]), .Dout(Q_sam_3[4]));
inv_delay mux_delay5 (.Din(Q_sam_2[5]), .Dout(Q_sam_3[5]));
inv_delay mux_delay6 (.Din(Q_sam_2[6]), .Dout(Q_sam_3[6]));
inv_delay mux_delay7 (.Din(Q_sam_2[7]), .Dout(Q_sam_3[7]));
inv_delay mux_delay8 (.Din(Q_sam_2[8]), .Dout(Q_sam_3[8]));
inv_delay mux_delay9 (.Din(Q_sam_2[9]), .Dout(Q_sam_3[9]));

sky130_fd_sc_hd__dfxtp_2 row0_02 (.Q(Q_sam_2[0]), .CLK(clock[0]), .D(Q_sam_d0));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_12 (.Q(Q_sam_2[1]), .CLK(clock[0]), .D(Q_sam[1]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_22 (.Q(Q_sam_2[2]), .CLK(clock[0]), .D(Q_sam[2]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_32 (.Q(Q_sam_2[3]), .CLK(clock[0]), .D(Q_sam[3]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row0_42 (.Q(Q_sam_2[4]), .CLK(clock[0]), .D(Q_sam[4]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

sky130_fd_sc_hd__dfxtp_2 row1_02 (.Q(Q_sam_2[5]), .CLK(clock[5]), .D(Q_sam_d5));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_12 (.Q(Q_sam_2[6]), .CLK(clock[5]), .D(Q_sam[6]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_22 (.Q(Q_sam_2[7]), .CLK(clock[5]), .D(Q_sam[7]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_32 (.Q(Q_sam_2[8]), .CLK(clock[5]), .D(Q_sam[8]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__dfxtp_2 row1_42 (.Q(Q_sam_2[9]), .CLK(clock[5]), .D(Q_sam[9]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

sky130_fd_sc_hd__mux2 mux0 (.X(Dout[0]), .A0(Q_sam_3[5]), .A1(Q_sam_3[0]), .S(clock[0]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2 mux1 (.X(Dout[1]), .A0(Q_sam_3[6]), .A1(Q_sam_3[1]), .S(clock[0]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2 mux2 (.X(Dout[2]), .A0(Q_sam_3[7]), .A1(Q_sam_3[2]), .S(clock[0]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2 mux3 (.X(Dout[3]), .A0(Q_sam_3[8]), .A1(Q_sam_3[3]), .S(clock[0]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__mux2 mux4 (.X(Dout[4]), .A0(Q_sam_3[9]), .A1(Q_sam_3[4]), .S(clock[0]));//, .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

endmodule

module inv_delay(
    input Din,
    output reg Dout
    //,
    //inout VDD,
    //inout GND
);
wire [14:0] D;
wire Dout_delay;

always @(*) begin
    #0.8 Dout = Dout_delay;
end

sky130_fd_sc_hd__bufinv_16 inv1 (.Y(D[0]), .A(Din));//.VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv2 (.Y(D[1]), .A(D[0]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv3 (.Y(D[2]), .A(D[1]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv4 (.Y(D[3]), .A(D[2]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv5 (.Y(D[4]), .A(D[3]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv6 (.Y(D[5]), .A(D[4]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv7 (.Y(D[6]), .A(D[5]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv8 (.Y(D[7]), .A(D[6]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv9 (.Y(D[8]), .A(D[7]));//.VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv10 (.Y(D[9]), .A(D[8]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv11 (.Y(D[10]), .A(D[9]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv12 (.Y(D[11]), .A(D[10]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv13 (.Y(D[12]), .A(D[11]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv14 (.Y(D[13]), .A(D[12]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv15 (.Y(D[14]), .A(D[13]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));
sky130_fd_sc_hd__bufinv_16 inv16 (.Y(Dout_delay), .A(D[14]));// .VPWR(VDD), .VGND(GND), .VPB(VDD), .VNB(GND));

endmodule

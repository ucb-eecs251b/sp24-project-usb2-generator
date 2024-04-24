# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.15-s090_1 on Tue Apr 23 18:35:38 PDT 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design data_recovery

set_load -pin_load 1.0 [get_ports data_out]
group_path -weight 1.000000 -name cg_enable_group_default -through [list \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST0/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST1/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST2/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST0/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST1/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST2/enable] ]
set_clock_gating_check -setup 0.0 
set_dont_touch [get_cells sampler]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__probe_p_8]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__probec_p_8]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfbbn_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfbbn_2]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfbbp_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfrbp_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfrbp_2]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfrtn_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfrtp_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfrtp_2]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfrtp_4]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfsbp_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfsbp_2]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfstp_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfstp_2]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfstp_4]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfxbp_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfxbp_2]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfxtp_1]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfxtp_2]
set_dont_use true [get_lib_cells sky130_fd_sc_hd__ss_100C_1v60/sky130_fd_sc_hd__sdfxtp_4]

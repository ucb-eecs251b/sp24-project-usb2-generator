# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.15-s090_1 on Thu Apr 25 16:09:31 PDT 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design data_recovery

create_clock -name "clock_480" -period 2.08 -waveform {0.0 1.04} [get_ports clock_480]
create_clock -name "clock_0" -period 4.16 -waveform {0.0 2.08} [get_ports clock_0]
create_generated_clock -name "clock_1"    -edges {1 2 3} -edge_shift {0.416 0.416 0.416} -source [get_ports clock_0]   [get_ports clock_1] 
create_generated_clock -name "clock_2"    -edges {1 2 3} -edge_shift {0.832 0.832 0.832} -source [get_ports clock_0]   [get_ports clock_2] 
create_generated_clock -name "clock_3"    -edges {1 2 3} -edge_shift {1.248 1.248 1.248} -source [get_ports clock_0]   [get_ports clock_3] 
create_generated_clock -name "clock_4"    -edges {1 2 3} -edge_shift {1.664 1.664 1.664} -source [get_ports clock_0]   [get_ports clock_4] 
create_generated_clock -name "clock_5"    -edges {1 2 3} -edge_shift {2.08 2.08 2.08} -source [get_ports clock_0]   [get_ports clock_5] 
create_generated_clock -name "clock_6"    -edges {1 2 3} -edge_shift {2.496 2.496 2.496} -source [get_ports clock_0]   [get_ports clock_6] 
create_generated_clock -name "clock_7"    -edges {1 2 3} -edge_shift {2.912 2.912 2.912} -source [get_ports clock_0]   [get_ports clock_7] 
create_generated_clock -name "clock_8"    -edges {1 2 3} -edge_shift {3.328 3.328 3.328} -source [get_ports clock_0]   [get_ports clock_8] 
create_generated_clock -name "clock_9"    -edges {1 2 3} -edge_shift {3.744 3.744 3.744} -source [get_ports clock_0]   [get_ports clock_9] 
set_load -pin_load 1.0 [get_ports data_out]
set_clock_groups -name "clock_groups_clock_480_to_others" -allow_paths -asynchronous -group [get_clocks clock_480]
set_clock_groups -name "clock_groups_clock_0_clock_1_clock_2_clock_3_clock_4_clock_5_clock_6_clock_7_clock_8_clock_9_to_others" -allow_paths -asynchronous -group [list \
  [get_clocks clock_0]  \
  [get_clocks clock_1]  \
  [get_clocks clock_2]  \
  [get_clocks clock_3]  \
  [get_clocks clock_4]  \
  [get_clocks clock_5]  \
  [get_clocks clock_6]  \
  [get_clocks clock_7]  \
  [get_clocks clock_8]  \
  [get_clocks clock_9] ]
group_path -weight 1.000000 -name cg_enable_group_clock_480 -through [list \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST0/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST1/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST2/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST0/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST1/enable]  \
  [get_pins crd/CLKGATE_RC_CG_HIER_INST2/enable] ]
set_clock_gating_check -setup 0.0 
set_clock_uncertainty -setup 0.001 [get_clocks clock_480]
set_clock_uncertainty -hold 0.001 [get_clocks clock_480]
set_clock_uncertainty -setup 0.001 [get_clocks clock_0]
set_clock_uncertainty -hold 0.001 [get_clocks clock_0]
set_clock_uncertainty -setup 0.001 [get_clocks clock_1]
set_clock_uncertainty -hold 0.001 [get_clocks clock_1]
set_clock_uncertainty -setup 0.001 [get_clocks clock_2]
set_clock_uncertainty -hold 0.001 [get_clocks clock_2]
set_clock_uncertainty -setup 0.001 [get_clocks clock_3]
set_clock_uncertainty -hold 0.001 [get_clocks clock_3]
set_clock_uncertainty -setup 0.001 [get_clocks clock_4]
set_clock_uncertainty -hold 0.001 [get_clocks clock_4]
set_clock_uncertainty -setup 0.001 [get_clocks clock_5]
set_clock_uncertainty -hold 0.001 [get_clocks clock_5]
set_clock_uncertainty -setup 0.001 [get_clocks clock_6]
set_clock_uncertainty -hold 0.001 [get_clocks clock_6]
set_clock_uncertainty -setup 0.001 [get_clocks clock_7]
set_clock_uncertainty -hold 0.001 [get_clocks clock_7]
set_clock_uncertainty -setup 0.001 [get_clocks clock_8]
set_clock_uncertainty -hold 0.001 [get_clocks clock_8]
set_clock_uncertainty -setup 0.001 [get_clocks clock_9]
set_clock_uncertainty -hold 0.001 [get_clocks clock_9]

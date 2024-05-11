# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.15-s090_1 on Tue Apr 23 18:35:39 PDT 2024

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

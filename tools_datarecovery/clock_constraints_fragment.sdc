# --------------------------------------------------------------------------------
# This script was written and developed by HAMMER at UC Berkeley; however, the
# underlying commands and reports are copyrighted by Cadence. We thank Cadence for
# granting permission to share our research to help promote and foster the next
# generation of innovators.
# --------------------------------------------------------------------------------

create_clock clock_480 -name clock_480 -period 2.08
set_clock_uncertainty 0.001 [get_clocks clock_480]
set_clock_groups -asynchronous -allow_paths -group { clock_480 }

create_clock clock_0 -name clock_0 -period 4.16
create_generated_clock -name clock_1 -source clock_0 -edges {1 2 3} -edge_shift {0.416 0.416 0.416} clock_1
create_generated_clock -name clock_2 -source clock_0 -edges {1 2 3} -edge_shift {0.832 0.832 0.832} clock_2
create_generated_clock -name clock_3 -source clock_0 -edges {1 2 3} -edge_shift {1.248 1.248 1.248} clock_3
create_generated_clock -name clock_4 -source clock_0 -edges {1 2 3} -edge_shift {1.664 1.664 1.664} clock_4
create_generated_clock -name clock_5 -source clock_0 -edges {1 2 3} -edge_shift {2.080 2.080 2.080} clock_5
create_generated_clock -name clock_6 -source clock_0 -edges {1 2 3} -edge_shift {2.496 2.496 2.496} clock_6
create_generated_clock -name clock_7 -source clock_0 -edges {1 2 3} -edge_shift {2.912 2.912 2.912} clock_7
create_generated_clock -name clock_8 -source clock_0 -edges {1 2 3} -edge_shift {3.328 3.328 3.328} clock_8
create_generated_clock -name clock_9 -source clock_0 -edges {1 2 3} -edge_shift {3.744 3.744 3.744} clock_9

set_clock_uncertainty 0.001 [get_clocks clock_0]
set_clock_uncertainty 0.001 [get_clocks clock_1]
set_clock_uncertainty 0.001 [get_clocks clock_2]
set_clock_uncertainty 0.001 [get_clocks clock_3]
set_clock_uncertainty 0.001 [get_clocks clock_4]
set_clock_uncertainty 0.001 [get_clocks clock_5]
set_clock_uncertainty 0.001 [get_clocks clock_6]
set_clock_uncertainty 0.001 [get_clocks clock_7]
set_clock_uncertainty 0.001 [get_clocks clock_8]
set_clock_uncertainty 0.001 [get_clocks clock_9]

set_clock_groups -asynchronous -allow_paths -group { clock_0 clock_1 clock_2 clock_3 clock_4 clock_5 clock_6 clock_7 clock_8 clock_9 }

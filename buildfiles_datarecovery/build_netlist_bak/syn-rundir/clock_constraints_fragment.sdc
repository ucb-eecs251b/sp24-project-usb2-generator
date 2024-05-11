# --------------------------------------------------------------------------------
# This script was written and developed by HAMMER at UC Berkeley; however, the
# underlying commands and reports are copyrighted by Cadence. We thank Cadence for
# granting permission to share our research to help promote and foster the next
# generation of innovators.
# --------------------------------------------------------------------------------

create_clock clock_0 -name clock_0 -period 2.0
create_generated_clock -name clock_1 -source clock_0 -edges {1 2 3} -edge_shift {0.4 0.4 0.4} clock_1
create_generated_clock -name clock_2 -source clock_0 -edges {1 2 3} -edge_shift {0.8 0.8 0.8} clock_2
create_generated_clock -name clock_3 -source clock_0 -edges {1 2 3} -edge_shift {1.2 1.2 1.2} clock_3
create_generated_clock -name clock_4 -source clock_0 -edges {1 2 3} -edge_shift {1.6 1.6 1.6} clock_4

set_clock_uncertainty 0.1 [get_clocks clock_0]
set_clock_uncertainty 0.1 [get_clocks clock_1]
set_clock_uncertainty 0.1 [get_clocks clock_2]
set_clock_uncertainty 0.1 [get_clocks clock_3]
set_clock_uncertainty 0.1 [get_clocks clock_4]

set_clock_groups -asynchronous -allow_paths -group { clock_0 clock_1 clock_2 clock_3 clock_4 }


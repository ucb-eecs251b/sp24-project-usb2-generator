# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Fri Apr 12 00:48:08 2024
# Designs open: 1
#   V1: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rundir/vcdplus.vpd
# Toplevel windows open: 3
# 	TopLevel.1
# 	TopLevel.2
# 	TopLevel.3
#   Source.1: ad_fifo_tb
#   Wave.1: 44 signals
#   Wave.2: 8 signals
#   Group count = 23
#   Group Group1 signal count = 8
#   Group Group2 signal count = 16
#   Group Group3 signal count = 8
#   Group Group4 signal count = 17
#   Group Group5 signal count = 16
#   Group Group6 signal count = 16
#   Group Group7 signal count = 16
#   Group Group8 signal count = 16
#   Group Group9 signal count = 2
#   Group Group10 signal count = 1
#   Group Group11 signal count = 16
#   Group Group12 signal count = 16
#   Group Group13 signal count = 1
#   Group Group14 signal count = 1
#   Group Group15 signal count = 17
#   Group Group16 signal count = 22
#   Group Group17 signal count = 22
#   Group Group18 signal count = 4
#   Group Group19 signal count = 22
#   Group Group20 signal count = 22
#   Group Group21 signal count = 8
#   Group Group22 signal count = 17
#   Group Group23 signal count = 18
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#<Session mode="Reload" path="/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rundir/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Reload
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all
gui_clear_window -type Wave
gui_clear_window -type List

# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

set TopLevel.1 TopLevel.1

# Docked window settings
set HSPane.1 HSPane.1
set Hier.1 Hier.1
set DLPane.1 DLPane.1
set Data.1 Data.1
set Console.1 Console.1
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 Source.1
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.2

set TopLevel.2 TopLevel.2

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 Wave.1
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 689} {child_wave_right 1682} {child_wave_colname 347} {child_wave_colvalue 338} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


# Create and position top-level window: TopLevel.3

set TopLevel.3 TopLevel.3

# Docked window settings
gui_sync_global -id ${TopLevel.3} -option true

# MDI window settings
set Wave.2 Wave.2
gui_update_layout -id ${Wave.2} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 618} {child_wave_right 1506} {child_wave_colname 311} {child_wave_colvalue 303} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rundir/vcdplus.vpd}] } {
	gui_open_db -design V1 -file /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rundir/vcdplus.vpd -nosource
}
gui_set_precision 1ps
gui_set_time_units 1ps
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {ad_fifo_tb.dut}
gui_load_child_values {ad_fifo_tb}
gui_load_child_values {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC}
gui_load_child_values {ad_fifo_tb.dut.cell_instance[21].cell_inst}
gui_load_child_values {ad_fifo_tb.dut.cell_instance[20].cell_inst}


set _session_group_168 Group1
gui_sg_create "$_session_group_168"
set Group1 "$_session_group_168"

gui_sg_addsignal -group "$_session_group_168" { ad_fifo_tb.CRD ad_fifo_tb.Add ad_fifo_tb.Drop ad_fifo_tb.Clock ad_fifo_tb.Reset ad_fifo_tb.Underflow ad_fifo_tb.Overflow ad_fifo_tb.Data }

set _session_group_169 Group2
gui_sg_create "$_session_group_169"
set Group2 "$_session_group_169"

gui_sg_addsignal -group "$_session_group_169" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.cell_output} {ad_fifo_tb.dut.cell_instance[20].cell_inst.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_q} }

set _session_group_170 Group3
gui_sg_create "$_session_group_170"
set Group3 "$_session_group_170"

gui_sg_addsignal -group "$_session_group_170" { ad_fifo_tb.CRD ad_fifo_tb.Add ad_fifo_tb.Drop ad_fifo_tb.Clock ad_fifo_tb.Reset ad_fifo_tb.Underflow ad_fifo_tb.Overflow ad_fifo_tb.Data }

set _session_group_171 Group4
gui_sg_create "$_session_group_171"
set Group4 "$_session_group_171"

gui_sg_addsignal -group "$_session_group_171" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.cell_output} {ad_fifo_tb.dut.cell_instance[20].cell_inst.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_q} }

set _session_group_172 Group5
gui_sg_create "$_session_group_172"
set Group5 "$_session_group_172"

gui_sg_addsignal -group "$_session_group_172" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} }

set _session_group_173 Group6
gui_sg_create "$_session_group_173"
set Group6 "$_session_group_173"

gui_sg_addsignal -group "$_session_group_173" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} }

set _session_group_174 Group7
gui_sg_create "$_session_group_174"
set Group7 "$_session_group_174"

gui_sg_addsignal -group "$_session_group_174" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} }

set _session_group_175 Group8
gui_sg_create "$_session_group_175"
set Group8 "$_session_group_175"

gui_sg_addsignal -group "$_session_group_175" { ad_fifo_tb.dut.CRD ad_fifo_tb.dut.Add ad_fifo_tb.dut.Drop ad_fifo_tb.dut.Clock ad_fifo_tb.dut.Reset ad_fifo_tb.dut.Underflow ad_fifo_tb.dut.Overflow ad_fifo_tb.dut.Data ad_fifo_tb.dut.crd ad_fifo_tb.dut.add ad_fifo_tb.dut.drop ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.clk ad_fifo_tb.dut.reset ad_fifo_tb.dut.cell_output }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}

set _session_group_176 Group9
gui_sg_create "$_session_group_176"
set Group9 "$_session_group_176"

gui_sg_addsignal -group "$_session_group_176" { ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}

set _session_group_177 Group10
gui_sg_create "$_session_group_177"
set Group10 "$_session_group_177"

gui_sg_addsignal -group "$_session_group_177" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.ptr_left} }

set _session_group_178 Group11
gui_sg_create "$_session_group_178"
set Group11 "$_session_group_178"

gui_sg_addsignal -group "$_session_group_178" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} }

set _session_group_179 Group12
gui_sg_create "$_session_group_179"
set Group12 "$_session_group_179"

gui_sg_addsignal -group "$_session_group_179" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} }

set _session_group_180 Group13
gui_sg_create "$_session_group_180"
set Group13 "$_session_group_180"

gui_sg_addsignal -group "$_session_group_180" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} }

set _session_group_181 Group14
gui_sg_create "$_session_group_181"
set Group14 "$_session_group_181"

gui_sg_addsignal -group "$_session_group_181" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.ptr_left} }

set _session_group_182 Group15
gui_sg_create "$_session_group_182"
set Group15 "$_session_group_182"

gui_sg_addsignal -group "$_session_group_182" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.cell_output} {ad_fifo_tb.dut.cell_instance[20].cell_inst.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_q} }

set _session_group_183 Group16
gui_sg_create "$_session_group_183"
set Group16 "$_session_group_183"

gui_sg_addsignal -group "$_session_group_183" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_q} }

set _session_group_184 Group17
gui_sg_create "$_session_group_184"
set Group17 "$_session_group_184"

gui_sg_addsignal -group "$_session_group_184" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_q} }

set _session_group_185 Group18
gui_sg_create "$_session_group_185"
set Group18 "$_session_group_185"

gui_sg_addsignal -group "$_session_group_185" { ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.add ad_fifo_tb.dut.drop }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}

set _session_group_186 Group19
gui_sg_create "$_session_group_186"
set Group19 "$_session_group_186"

gui_sg_addsignal -group "$_session_group_186" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_q} }

set _session_group_187 Group20
gui_sg_create "$_session_group_187"
set Group20 "$_session_group_187"

gui_sg_addsignal -group "$_session_group_187" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_q} }

set _session_group_188 Group21
gui_sg_create "$_session_group_188"
set Group21 "$_session_group_188"

gui_sg_addsignal -group "$_session_group_188" { ad_fifo_tb.CRD ad_fifo_tb.Add ad_fifo_tb.Drop ad_fifo_tb.Clock ad_fifo_tb.Reset ad_fifo_tb.Underflow ad_fifo_tb.Overflow ad_fifo_tb.Data }

set _session_group_189 Group22
gui_sg_create "$_session_group_189"
set Group22 "$_session_group_189"

gui_sg_addsignal -group "$_session_group_189" { ad_fifo_tb.dut.CRD ad_fifo_tb.dut.Add ad_fifo_tb.dut.Drop ad_fifo_tb.dut.Clock ad_fifo_tb.dut.Reset ad_fifo_tb.dut.Underflow ad_fifo_tb.dut.Overflow ad_fifo_tb.dut.Data ad_fifo_tb.dut.crd ad_fifo_tb.dut.add ad_fifo_tb.dut.drop ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.clk ad_fifo_tb.dut.reset ad_fifo_tb.dut.cell_output ad_fifo_tb.dut.has_token_rst }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}

set _session_group_190 Group23
gui_sg_create "$_session_group_190"
set Group23 "$_session_group_190"

gui_sg_addsignal -group "$_session_group_190" { ad_fifo_tb.dut.CRD ad_fifo_tb.dut.Add ad_fifo_tb.dut.Drop ad_fifo_tb.dut.Clock ad_fifo_tb.dut.Reset ad_fifo_tb.dut.Underflow ad_fifo_tb.dut.Overflow ad_fifo_tb.dut.Data ad_fifo_tb.dut.crd ad_fifo_tb.dut.add ad_fifo_tb.dut.drop ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.clk ad_fifo_tb.dut.reset ad_fifo_tb.dut.cell_output ad_fifo_tb.dut.has_token_rst ad_fifo_tb.dut.token }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.token}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.token}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 178668



# Save global setting...

# Wave/List view global setting
gui_list_create_group_when_add -wave -enable
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*} -force
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} ad_fifo_tb}
catch {gui_list_select -id ${Hier.1} {ad_fifo_tb.dut}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {ad_fifo_tb.dut}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active ad_fifo_tb /scratch/eecs251b-aaw/sp24-project-usb2-generator/src/ad_fifo_tb.v
gui_view_scroll -id ${Source.1} -vertical -set 0
gui_src_set_reusable -id ${Source.1}

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.1} 171400 200471
gui_list_add_group -id ${Wave.1} -after {New Group} {Group19}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group20}
gui_list_select -id ${Wave.1} {{ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} }
gui_seek_criteria -id ${Wave.1} {Any Edge}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group Group20  -position in

gui_marker_move -id ${Wave.1} {C1} 178668
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false

# View 'Wave.2'
gui_wv_sync -id ${Wave.2} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.2} 104613 267222
gui_list_add_group -id ${Wave.2} -after {New Group} {Group21}
gui_list_select -id ${Wave.2} {ad_fifo_tb.Overflow }
gui_seek_criteria -id ${Wave.2} {Any Edge}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.2} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.2} -text {*}
gui_list_set_insertion_bar  -id ${Wave.2} -group Group21  -position in

gui_marker_move -id ${Wave.2} {C1} 178668
gui_view_scroll -id ${Wave.2} -vertical -set 0
gui_show_grid -id ${Wave.2} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.3}]} {
	gui_set_active_window -window ${TopLevel.3}
	gui_set_active_window -window ${Wave.2}
}
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Source.1}
	gui_set_active_window -window ${HSPane.1}
}
#</Session>


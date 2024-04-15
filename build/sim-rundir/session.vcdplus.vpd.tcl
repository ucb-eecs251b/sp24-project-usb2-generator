# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Fri Apr 12 01:00:49 2024
# Designs open: 1
#   V1: vcdplus.vpd
# Toplevel windows open: 4
# 	TopLevel.1
# 	TopLevel.2
# 	TopLevel.3
# 	TopLevel.4
#   Source.1: ad_fifo_tb
#   Wave.1: 44 signals
#   Wave.2: 8 signals
#   Wave.3: 23 signals
#   Group count = 26
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
#   Group Group23 signal count = 17
#   Group Group24 signal count = 18
#   Group Group25 signal count = 0
#   Group Group26 signal count = 5
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#<Session mode="Full" path="/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rundir/session.vcdplus.vpd.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

if {![gui_exist_window -window TopLevel.1]} {
    set TopLevel.1 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.1 TopLevel.1
}
gui_show_window -window ${TopLevel.1} -show_state normal -rect {{1 -83} {2533 1233}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_hide_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 439]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 439
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 438} {height 1045} {dock_state left} {dock_on_new_line true} {child_hier_colhier 279} {child_hier_coltype 150} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 565]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 565
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 1026
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 564} {height 1045} {dock_state left} {dock_on_new_line true} {child_data_colvariable 228} {child_data_colvalue 188} {child_data_coltype 138} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 177]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 2524
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 177
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 2532} {height 176} {dock_state bottom} {dock_on_new_line true}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.1}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.2

if {![gui_exist_window -window TopLevel.2]} {
    set TopLevel.2 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.2 TopLevel.2
}
gui_show_window -window ${TopLevel.2} -show_state normal -rect {{132 86} {2508 1360}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 [gui_create_window -type {Wave}  -parent ${TopLevel.2}]
gui_show_window -window ${Wave.1} -show_state maximized
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 689} {child_wave_right 1682} {child_wave_colname 347} {child_wave_colvalue 338} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


# Create and position top-level window: TopLevel.3

if {![gui_exist_window -window TopLevel.3]} {
    set TopLevel.3 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.3 TopLevel.3
}
gui_show_window -window ${TopLevel.3} -show_state normal -rect {{235 386} {2364 1508}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.3} -option true

# MDI window settings
set Wave.2 [gui_create_window -type {Wave}  -parent ${TopLevel.3}]
gui_show_window -window ${Wave.2} -show_state maximized
gui_update_layout -id ${Wave.2} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 618} {child_wave_right 1506} {child_wave_colname 311} {child_wave_colvalue 303} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


# Create and position top-level window: TopLevel.4

if {![gui_exist_window -window TopLevel.4]} {
    set TopLevel.4 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.4 TopLevel.4
}
gui_show_window -window ${TopLevel.4} -show_state normal -rect {{237 199} {2364 1319}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.4} -option true

# MDI window settings
set Wave.3 [gui_create_window -type {Wave}  -parent ${TopLevel.4}]
gui_show_window -window ${Wave.3} -show_state maximized
gui_update_layout -id ${Wave.3} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 645} {child_wave_right 1477} {child_wave_colname 255} {child_wave_colvalue 387} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.1}
gui_update_statusbar_target_frame ${TopLevel.2}
gui_update_statusbar_target_frame ${TopLevel.3}
gui_update_statusbar_target_frame ${TopLevel.4}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {vcdplus.vpd}] } {
	gui_open_db -design V1 -file vcdplus.vpd -nosource
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


set _session_group_191 Group1
gui_sg_create "$_session_group_191"
set Group1 "$_session_group_191"

gui_sg_addsignal -group "$_session_group_191" { ad_fifo_tb.CRD ad_fifo_tb.Add ad_fifo_tb.Drop ad_fifo_tb.Clock ad_fifo_tb.Reset ad_fifo_tb.Underflow ad_fifo_tb.Overflow ad_fifo_tb.Data }

set _session_group_192 Group2
gui_sg_create "$_session_group_192"
set Group2 "$_session_group_192"

gui_sg_addsignal -group "$_session_group_192" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.cell_output} {ad_fifo_tb.dut.cell_instance[20].cell_inst.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_q} }

set _session_group_193 Group3
gui_sg_create "$_session_group_193"
set Group3 "$_session_group_193"

gui_sg_addsignal -group "$_session_group_193" { ad_fifo_tb.CRD ad_fifo_tb.Add ad_fifo_tb.Drop ad_fifo_tb.Clock ad_fifo_tb.Reset ad_fifo_tb.Underflow ad_fifo_tb.Overflow ad_fifo_tb.Data }

set _session_group_194 Group4
gui_sg_create "$_session_group_194"
set Group4 "$_session_group_194"

gui_sg_addsignal -group "$_session_group_194" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.cell_output} {ad_fifo_tb.dut.cell_instance[20].cell_inst.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_q} }

set _session_group_195 Group5
gui_sg_create "$_session_group_195"
set Group5 "$_session_group_195"

gui_sg_addsignal -group "$_session_group_195" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} }

set _session_group_196 Group6
gui_sg_create "$_session_group_196"
set Group6 "$_session_group_196"

gui_sg_addsignal -group "$_session_group_196" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} }

set _session_group_197 Group7
gui_sg_create "$_session_group_197"
set Group7 "$_session_group_197"

gui_sg_addsignal -group "$_session_group_197" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} }

set _session_group_198 Group8
gui_sg_create "$_session_group_198"
set Group8 "$_session_group_198"

gui_sg_addsignal -group "$_session_group_198" { ad_fifo_tb.dut.CRD ad_fifo_tb.dut.Add ad_fifo_tb.dut.Drop ad_fifo_tb.dut.Clock ad_fifo_tb.dut.Reset ad_fifo_tb.dut.Underflow ad_fifo_tb.dut.Overflow ad_fifo_tb.dut.Data ad_fifo_tb.dut.crd ad_fifo_tb.dut.add ad_fifo_tb.dut.drop ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.clk ad_fifo_tb.dut.reset ad_fifo_tb.dut.cell_output }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}

set _session_group_199 Group9
gui_sg_create "$_session_group_199"
set Group9 "$_session_group_199"

gui_sg_addsignal -group "$_session_group_199" { ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}

set _session_group_200 Group10
gui_sg_create "$_session_group_200"
set Group10 "$_session_group_200"

gui_sg_addsignal -group "$_session_group_200" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.ptr_left} }

set _session_group_201 Group11
gui_sg_create "$_session_group_201"
set Group11 "$_session_group_201"

gui_sg_addsignal -group "$_session_group_201" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} }

set _session_group_202 Group12
gui_sg_create "$_session_group_202"
set Group12 "$_session_group_202"

gui_sg_addsignal -group "$_session_group_202" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} }

set _session_group_203 Group13
gui_sg_create "$_session_group_203"
set Group13 "$_session_group_203"

gui_sg_addsignal -group "$_session_group_203" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} }

set _session_group_204 Group14
gui_sg_create "$_session_group_204"
set Group14 "$_session_group_204"

gui_sg_addsignal -group "$_session_group_204" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.ptr_left} }

set _session_group_205 Group15
gui_sg_create "$_session_group_205"
set Group15 "$_session_group_205"

gui_sg_addsignal -group "$_session_group_205" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.cell_output} {ad_fifo_tb.dut.cell_instance[20].cell_inst.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.crd_q} }

set _session_group_206 Group16
gui_sg_create "$_session_group_206"
set Group16 "$_session_group_206"

gui_sg_addsignal -group "$_session_group_206" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_q} }

set _session_group_207 Group17
gui_sg_create "$_session_group_207"
set Group17 "$_session_group_207"

gui_sg_addsignal -group "$_session_group_207" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_q} }

set _session_group_208 Group18
gui_sg_create "$_session_group_208"
set Group18 "$_session_group_208"

gui_sg_addsignal -group "$_session_group_208" { ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.add ad_fifo_tb.dut.drop }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}

set _session_group_209 Group19
gui_sg_create "$_session_group_209"
set Group19 "$_session_group_209"

gui_sg_addsignal -group "$_session_group_209" { {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.has_token_q} }

set _session_group_210 Group20
gui_sg_create "$_session_group_210"
set Group20 "$_session_group_210"

gui_sg_addsignal -group "$_session_group_210" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.clk} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.reset} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_right} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.token} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_rst} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.add_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.drop_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptr_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.ptl_q} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_d} {ad_fifo_tb.dut.cell_instance[21].cell_inst.TC.has_token_q} }

set _session_group_211 Group21
gui_sg_create "$_session_group_211"
set Group21 "$_session_group_211"

gui_sg_addsignal -group "$_session_group_211" { ad_fifo_tb.CRD ad_fifo_tb.Add ad_fifo_tb.Drop ad_fifo_tb.Clock ad_fifo_tb.Reset ad_fifo_tb.Underflow ad_fifo_tb.Overflow ad_fifo_tb.Data }

set _session_group_212 Group22
gui_sg_create "$_session_group_212"
set Group22 "$_session_group_212"

gui_sg_addsignal -group "$_session_group_212" { ad_fifo_tb.dut.CRD ad_fifo_tb.dut.Add ad_fifo_tb.dut.Drop ad_fifo_tb.dut.Clock ad_fifo_tb.dut.Reset ad_fifo_tb.dut.Underflow ad_fifo_tb.dut.Overflow ad_fifo_tb.dut.Data ad_fifo_tb.dut.crd ad_fifo_tb.dut.add ad_fifo_tb.dut.drop ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.clk ad_fifo_tb.dut.reset ad_fifo_tb.dut.cell_output ad_fifo_tb.dut.has_token_rst }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}

set _session_group_213 Group23
gui_sg_create "$_session_group_213"
set Group23 "$_session_group_213"

gui_sg_addsignal -group "$_session_group_213" { ad_fifo_tb.dut.CRD ad_fifo_tb.dut.Add ad_fifo_tb.dut.Drop ad_fifo_tb.dut.Clock ad_fifo_tb.dut.Reset ad_fifo_tb.dut.Underflow ad_fifo_tb.dut.Overflow ad_fifo_tb.dut.Data ad_fifo_tb.dut.crd ad_fifo_tb.dut.add ad_fifo_tb.dut.drop ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.clk ad_fifo_tb.dut.reset ad_fifo_tb.dut.cell_output ad_fifo_tb.dut.has_token_rst }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}

set _session_group_214 Group24
gui_sg_create "$_session_group_214"
set Group24 "$_session_group_214"

gui_sg_addsignal -group "$_session_group_214" { ad_fifo_tb.dut.CRD ad_fifo_tb.dut.Add ad_fifo_tb.dut.Drop ad_fifo_tb.dut.Clock ad_fifo_tb.dut.Reset ad_fifo_tb.dut.Underflow ad_fifo_tb.dut.Overflow ad_fifo_tb.dut.Data ad_fifo_tb.dut.crd ad_fifo_tb.dut.add ad_fifo_tb.dut.drop ad_fifo_tb.dut.ptr ad_fifo_tb.dut.ptl ad_fifo_tb.dut.clk ad_fifo_tb.dut.reset ad_fifo_tb.dut.cell_output ad_fifo_tb.dut.has_token_rst ad_fifo_tb.dut.token_out }
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.add}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.drop}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptr}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.ptl}
gui_set_radix -radix {binary} -signals {V1:ad_fifo_tb.dut.token_out}
gui_set_radix -radix {unsigned} -signals {V1:ad_fifo_tb.dut.token_out}

set _session_group_215 Group25
gui_sg_create "$_session_group_215"
set Group25 "$_session_group_215"


set _session_group_216 Group26
gui_sg_create "$_session_group_216"
set Group26 "$_session_group_216"

gui_sg_addsignal -group "$_session_group_216" { {ad_fifo_tb.dut.cell_instance[21].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.token_out} {ad_fifo_tb.dut.cell_instance[21].cell_inst.cell_output} }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 45000



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
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} ad_fifo_tb}
catch {gui_list_expand -id ${Hier.1} ad_fifo_tb.dut}
catch {gui_list_select -id ${Hier.1} {{ad_fifo_tb.dut.cell_instance[21].cell_inst}}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {ad_fifo_tb.dut.cell_instance[21].cell_inst}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {{ad_fifo_tb.dut.cell_instance[21].cell_inst.crd_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.add_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.drop_left} {ad_fifo_tb.dut.cell_instance[21].cell_inst.token_out} {ad_fifo_tb.dut.cell_instance[21].cell_inst.cell_output} }}
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
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 28459 57530
gui_list_add_group -id ${Wave.1} -after {New Group} {Group19}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group20}
gui_list_select -id ${Wave.1} {{ad_fifo_tb.dut.cell_instance[20].cell_inst.TC.ptl_right} }
gui_seek_criteria -id ${Wave.1} {Any Edge}


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

gui_marker_move -id ${Wave.1} {C1} 45000
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
gui_marker_set_ref -id ${Wave.2}  C1
gui_wv_zoom_timerange -id ${Wave.2} 0 162609
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

gui_marker_move -id ${Wave.2} {C1} 45000
gui_view_scroll -id ${Wave.2} -vertical -set 0
gui_show_grid -id ${Wave.2} -enable false

# View 'Wave.3'
gui_wv_sync -id ${Wave.3} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.3}  C1
gui_wv_zoom_timerange -id ${Wave.3} 156892 359365
gui_list_add_group -id ${Wave.3} -after {New Group} {Group24}
gui_list_add_group -id ${Wave.3} -after {New Group} {Group25}
gui_list_add_group -id ${Wave.3} -after {New Group} {Group26}
gui_seek_criteria -id ${Wave.3} {Any Edge}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.3}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.3} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.3} -text {*}
gui_list_set_insertion_bar  -id ${Wave.3} -group Group26  -position in

gui_marker_move -id ${Wave.3} {C1} 45000
gui_view_scroll -id ${Wave.3} -vertical -set 0
gui_show_grid -id ${Wave.3} -enable false
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
	gui_set_active_window -window ${DLPane.1}
}
if {[gui_exist_window -window ${TopLevel.4}]} {
	gui_set_active_window -window ${TopLevel.4}
	gui_set_active_window -window ${Wave.3}
}
#</Session>


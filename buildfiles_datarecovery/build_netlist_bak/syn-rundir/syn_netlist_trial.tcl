# --------------------------------------------------------------------------------
# This script was written and developed by HAMMER at UC Berkeley; however, the
# underlying commands and reports are copyrighted by Cadence. We thank Cadence for
# granting permission to share our research to help promote and foster the next
# generation of innovators.
# --------------------------------------------------------------------------------

puts "set_db hdl_error_on_blackbox true" 
set_db hdl_error_on_blackbox true
puts "set_db max_cpus_per_server 4" 
set_db max_cpus_per_server 4
#puts "set_multi_cpu_usage -local_cpu 4" 
#set_multi_cpu_usage -local_cpu 4
puts "set_db super_thread_debug_jobs true" 
set_db super_thread_debug_jobs true
puts "set_db super_thread_debug_directory super_thread_debug" 
set_db super_thread_debug_directory super_thread_debug
puts "set_db lp_clock_gating_infer_enable  true" 
set_db lp_clock_gating_infer_enable  true
puts "set_db lp_clock_gating_prefix  {CLKGATE}" 
set_db lp_clock_gating_prefix  {CLKGATE}
puts "set_db lp_insert_clock_gating  true" 
set_db lp_insert_clock_gating  true
puts "set_db lp_clock_gating_register_aware true" 
set_db lp_clock_gating_register_aware true
puts "read_mmmc /scratch/eecs251b-aaz/sp24-project-usb2-generator/build/syn-rundir/mmmc.tcl" 
read_mmmc /scratch/eecs251b-aaz/sp24-project-usb2-generator/build/syn-rundir/mmmc.tcl
puts "read_physical -lef { /scratch/eecs251b-aaz/sp24-project-usb2-generator/build/tech-sky130-cache/sky130_fd_sc_hd__nom.tlef /home/ff/eecs151/fa23/pdk_mod/sky130/pdk/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef /scratch/eecs251b-aaz/sp24-project-usb2-generator/build/tech-sky130-cache/sky130_ef_io.lef /home/ff/eecs151/fa23/pdk_mod/sky130/pdk/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_1024x32m8w8/sram22_1024x32m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x32m4w32/sram22_64x32m4w32.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_1024x32m8w32/sram22_1024x32m8w32.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_512x32m4w32/sram22_512x32m4w32.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_2048x32m8w8/sram22_2048x32m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_512x32m4w8/sram22_512x32m4w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_4096x32m8w8/sram22_4096x32m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x4m4w2/sram22_64x4m4w2.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_256x32m4w8/sram22_256x32m4w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_4096x8m8w8/sram22_4096x8m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x32m4w8/sram22_64x32m4w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x24m4w24/sram22_64x24m4w24.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_512x64m4w8/sram22_512x64m4w8.lef }" 
read_physical -lef { /scratch/eecs251b-aaz/sp24-project-usb2-generator/build/tech-sky130-cache/sky130_fd_sc_hd__nom.tlef /home/ff/eecs151/fa23/pdk_mod/sky130/pdk/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef /scratch/eecs251b-aaz/sp24-project-usb2-generator/build/tech-sky130-cache/sky130_ef_io.lef /home/ff/eecs151/fa23/pdk_mod/sky130/pdk/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_1024x32m8w8/sram22_1024x32m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x32m4w32/sram22_64x32m4w32.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_1024x32m8w32/sram22_1024x32m8w32.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_512x32m4w32/sram22_512x32m4w32.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_2048x32m8w8/sram22_2048x32m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_512x32m4w8/sram22_512x32m4w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_4096x32m8w8/sram22_4096x32m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x4m4w2/sram22_64x4m4w2.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_256x32m4w8/sram22_256x32m4w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_4096x8m8w8/sram22_4096x8m8w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x32m4w8/sram22_64x32m4w8.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_64x24m4w24/sram22_64x24m4w24.lef /home/ff/eecs151/fa23/sky130_srams/sram22_sky130_macros/sram22_512x64m4w8/sram22_512x64m4w8.lef }
puts "read_hdl -sv { /scratch/eecs251b-aaz/sp24-project-usb2-generator/src/sampler_v2.v }" 
read_hdl -v { /scratch/eecs251b-aaz/sp24-project-usb2-generator/src/dr_syn.v }
puts "elaborate data_recovery" 
elaborate data_recovery
puts "init_design -top sampler" 
init_design -top data_recovery
#set_dont_touch design:sampler
puts "report_timing -lint -verbose" 
report_timing -lint -verbose
#syn_generic
#syn_map
#write_hdl > sampler_syn.v
#write_sdf > sampler_syn.sdf
#report_timing -unconstrained -max_paths 50 > reports/final_unconstrained.rpt
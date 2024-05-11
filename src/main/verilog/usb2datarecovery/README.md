Title: USB 2.0 Data Recovery System

Authors: Wei Foo, Justine Tsai

Data: May 6, 2024

Purpose: Recovers serial data send from transmitter to recevier without the Tx clock.

I/0:  
----- Inputs ----- | ----- Purpose -----  
data_in            | 1-bit input serial data from transmitter  
clock_480          | 480MHz clock (main clock for receiver)  
reset              | reset signal for receiver  
clock0 .. clock10  | 10-phase 240MHz clock for sampler  
---- Outputs ----- |  
data_out           | 1-bit recovered serial data to receiver  

Status:   
RTL Simulation passes testbench  
Synthesis passes with 81ps setup slack and 91ps hold slack  
PAR completed - system consumes 0.1mm x 0.1mm of area and 5.93uW of power  

Manifest of Files in src/main:  
----- File ----- | ----- Purpose -----  
dr_tb_v2.v       | Final RTL level testbench with 5 test cases  
dr_tb.v          | Original RTL level testbench with 3 test cases (deprecated)  
dr_toplevel.v    | Top level integration for RTL testing. Includes 10 phase clock that should not be synthesized  
dr_syn.v         | Top level integration for synthesis and PAR. Exclude unsynthesizable elements  
clock_gen_x5.v   | 5 phase, full-speed (480MHz) clock for sampler  
clock_gen_x10.v  | 10 phase, half-speed (240Mhz) clock for sampler  
sampler.v2.v     | Final sampler with dual-path, single-cycle design implmented using structural verilog  
sampler.v        | Original sampler with single-path, single-cycle design (deprecated)  
crd_tb.v         | Testbench for corse data recovery (CDR) block  
crd_sam_tb.v     | Testbench integrating CDR and sampler  
crd.v            | CDR block  
ad_fifo_tb.v     | Testbench for Add-Drop FIFO (AD_FIFO)  
ad_fifo.v        | Full integrated AD-FIFO with 41 individaul AD-FIFO cells  
ad_fifo_cell.v   | Individual AD-FIFO cell  
token_control.v  | FSM logic to control token in each AD-FIFO cell  

Future work:  
Post-layout simulation (sim-gl-par) does not run due to PDK error encountered by force_regs.ucli file. Debug PDK to run post-layout simulation  
END  
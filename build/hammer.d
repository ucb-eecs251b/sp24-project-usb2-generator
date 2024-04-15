HAMMER_EXEC ?= /home/cc/eecs251b/sp24/class/eecs251b-aaw/venv_151/bin/hammer-vlsi
HAMMER_DEPENDENCIES ?= /scratch/eecs251b-aaw/sp24-project-usb2-generator/sky130.yml /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sram_generator-output.json /scratch/eecs251b-aaw/sp24-project-usb2-generator/design.yml /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml /scratch/eecs251b-aaw/sp24-project-usb2-generator/src/ad_fifo.v /scratch/eecs251b-aaw/sp24-project-usb2-generator/src/token_control.v /scratch/eecs251b-aaw/sp24-project-usb2-generator/src/ad_fifo_cell.v


####################################################################################
## Global steps
####################################################################################
.PHONY: pcb
pcb: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/pcb-rundir/pcb-output-full.json

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/pcb-rundir/pcb-output-full.json: $(HAMMER_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/sky130.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sram_generator-output.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/design.yml --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build pcb


####################################################################################
## Steps for ad_fifo
####################################################################################
.PHONY: sim-rtl syn syn-to-sim sim-syn syn-to-par par par-to-sim sim-par sim-par-to-power par-to-power power-par power-rtl sim-rtl-to-power sim-syn-to-power syn-to-power power-syn par-to-drc drc par-to-lvs lvs syn-to-formal formal-syn par-to-formal formal-par syn-to-timing timing-syn par-to-timing timing-par

sim-rtl          : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rtl-rundir/sim-output-full.json
syn              : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json

syn-to-sim       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-input.json
sim-syn          : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-rundir/sim-output-full.json

syn-to-par       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-input.json
par              : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json

par-to-sim       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-input.json
sim-par          : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-rundir/sim-output-full.json

sim-par-to-power : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-par-input.json
par-to-power     : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-input.json
power-par        : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-rundir/power-output-full.json

sim-rtl-to-power : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-rtl-input.json
power-rtl        : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-rtl-rundir/power-output-full.json

sim-syn-to-power : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-syn-input.json
syn-to-power     : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-input.json
power-syn        : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-rundir/power-output-full.json

par-to-drc       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-input.json
drc              : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-rundir/drc-output-full.json

par-to-lvs       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-input.json
lvs              : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-rundir/lvs-output-full.json

syn-to-formal    : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json
formal-syn       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-rundir/formal-output-full.json

par-to-formal    : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-input.json
formal-par       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-rundir/formal-output-full.json

syn-to-timing    : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json
timing-syn       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-rundir/timing-output-full.json

par-to-timing    : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-input.json
timing-par       : /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-rundir/timing-output-full.json



/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rtl-rundir/sim-output-full.json: $(HAMMER_DEPENDENCIES) $(HAMMER_SIM_RTL_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/sky130.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sram_generator-output.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/design.yml $(HAMMER_EXTRA_ARGS) --sim_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rtl-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-rtl-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rtl-rundir/sim-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rtl-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-rtl-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim-to-power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-rtl-rundir/power-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-rtl-input.json $(HAMMER_POWER_RTL_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-rtl-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-rtl-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json: $(HAMMER_DEPENDENCIES) $(HAMMER_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/sky130.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sram_generator-output.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/design.yml $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-sim

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-rundir/sim-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-input.json $(HAMMER_SIM_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-input.json $(HAMMER_EXTRA_ARGS) --sim_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-syn-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-rundir/sim-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim-to-power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-rundir/power-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-syn-input.json /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-input.json $(HAMMER_POWER_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-syn-input.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-par

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-input.json $(HAMMER_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-sim

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-rundir/sim-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-input.json $(HAMMER_SIM_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-input.json $(HAMMER_EXTRA_ARGS) --sim_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-par-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-rundir/sim-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim-to-power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-rundir/power-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-par-input.json /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-input.json $(HAMMER_POWER_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-par-input.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build power

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-drc

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-rundir/drc-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-input.json $(HAMMER_DRC_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build drc

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-lvs

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-rundir/lvs-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-input.json $(HAMMER_LVS_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build lvs

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-formal

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-rundir/formal-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json $(HAMMER_FORMAL_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build formal

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-formal

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-rundir/formal-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json $(HAMMER_FORMAL_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build formal

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-timing

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-rundir/timing-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json $(HAMMER_TIMING_SYN_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build timing

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-input.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-timing

/scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-rundir/timing-output-full.json: /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json $(HAMMER_TIMING_PAR_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build timing

# Redo steps
# These intentionally break the dependency graph, but allow the flexibility to rerun a step after changing a config.
# Hammer doesn't know what settings impact synthesis only, e.g., so these are for power-users who "know better."
# The HAMMER_EXTRA_ARGS variable allows patching in of new configurations with -p or using --to_step or --from_step, for example.
.PHONY: redo-sim-rtl redo-sim-rtl-to-power redo-syn redo-syn-to-sim redo-syn-to-power redo-sim-syn redo-sim-syn-to-power redo-syn-to-par redo-par redo-par-to-sim redo-sim-par redo-sim-par-to-power redo-par-to-power redo-power-par redo-par-to-drc redo-drc redo-par-to-lvs redo-lvs redo-syn-to-formal redo-formal-syn redo-par-to-formal redo-formal-par redo-syn-to-timing redo-timing-syn redo-par-to-timing redo-timing-par

redo-sim-rtl:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/sky130.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sram_generator-output.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/design.yml $(HAMMER_EXTRA_ARGS) --sim_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rtl-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim

redo-sim-rtl-to-power:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-rtl-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-rtl-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim-to-power

redo-power-rtl:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-rtl-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-rtl-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build power

redo-syn:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/sky130.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sram_generator-output.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/design.yml $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn

redo-syn-to-sim:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-sim

redo-syn-to-power:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-power

redo-sim-syn:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-input.json $(HAMMER_EXTRA_ARGS) --sim_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim

redo-sim-syn-to-power:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-syn-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim-to-power

redo-syn-to-par:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-par

redo-power-syn:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-syn-input.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build power

redo-par:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par

redo-par-to-sim:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-sim

redo-sim-par:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-input.json $(HAMMER_EXTRA_ARGS) --sim_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim

redo-sim-par-to-power:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/sim-par-rundir/sim-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build sim-to-power

redo-par-to-power:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-power

redo-power-par:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-sim-par-input.json -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-input.json $(HAMMER_EXTRA_ARGS) --power_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/power-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build power

redo-par-to-drc:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-drc

redo-drc:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/drc-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build drc

redo-par-to-lvs:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-lvs

redo-lvs:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/lvs-input.json $(HAMMER_EXTRA_ARGS) --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build lvs

redo-syn-to-formal:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-formal

redo-formal-syn:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build formal

redo-par-to-formal:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-formal

redo-formal-par:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-input.json $(HAMMER_EXTRA_ARGS) --formal_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/formal-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build formal

redo-syn-to-timing:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/syn-rundir/syn-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build syn-to-timing

redo-timing-syn:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-syn-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build timing

redo-par-to-timing:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/par-rundir/par-output-full.json $(HAMMER_EXTRA_ARGS) -o /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-input.json --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build par-to-timing

redo-timing-par:
	$(HAMMER_EXEC) -e /scratch/eecs251b-aaw/sp24-project-usb2-generator/inst-env.yml -p /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-input.json $(HAMMER_EXTRA_ARGS) --timing_rundir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build/timing-par-rundir --obj_dir /scratch/eecs251b-aaw/sp24-project-usb2-generator/build timing


#!/bin/csh -fe

mypath="$PWD"

# Netlist
# Browse: ./Design/done_fanin.v

#step 1: Function Simulation
cd $mypath/1_simulate
source /apps/settings
vcs ./input/done_fanin.v ./input/tb_top.v -v ./input/saed32nm.v -R -debug_all +v2k -l log.txt
dve -vpd ./output/wave.vcd.vpd -session ./output/session.wave.vcd.vpd.tcl &
# Display: Do Nothing. A waveform window will pop up.

#step 2: Fault Simulation
cd $mypath/2_fault_sim/input
sh run.csh
gedit user_coverage.sff
# Display: show txt in ./2_fault_sim/input/user_coverage.sff

#step 3: Fault Analysis
cd $mypath/3_critical_location/input
python3 ./fault_analysis.py
gedit feasible_faults.sff
# Display: show txt in ./3_critical_location/input/feasible_faults.sff

#step 4: Fault Verification
cd $mypath/4_fault_verification
dve -vpd ./input/ff.fm1.vcd.vpd -session ./input/session.ff.fm1.vcd.vpd.tcl &
# Display: Do Nothing. A waveform window will pop up.

#clean outputs
#cd $mypath
#./clean.csh


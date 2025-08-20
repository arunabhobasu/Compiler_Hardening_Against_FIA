#!/bin/bash

#Script to clean up old files
sh clean.sh

#source required tools
source /apps/settings
# ZOIX compile
$ZOIXHOME/bin/zoix -f run.f strobe.sv +fault+var -w +sv -l zoix.log +notimingchecks
#./zoix.sim

# Run Fault Manager for testability, fault simulation, and coverage reports
$ZOIXHOME/bin/fmsh -load user.fmsh


./zoix.sim -fault +fault+machine+1 +vcd+file+input.vcd

#modify #0 in fm.vcd
#dve &

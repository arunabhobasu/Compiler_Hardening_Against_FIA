#!/bin/csh -fe

./clean.csh

# ZOIX compile
$ZOIXHOME/bin/zoix -f run.f strobe.sv +fault+var -w +sv -l zoix.log

# Run Fault Manager for testability, fault simulation, and coverage reports
$ZOIXHOME/bin/fmsh -load user.fmsh


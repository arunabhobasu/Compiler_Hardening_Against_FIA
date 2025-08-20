#!/bin/csh -fe

# Remove old files to ensure clean directory
set outputFileList=(./1_simulate/cds.lib \
  ./1_simulate/csrc \
  ./1_simulate/DVEfiles \
  ./1_simulate/input.vcd \
  ./1_simulate/log.txt \
  ./1_simulate/simv \
  ./1_simulate/simv.daidir \
  ./1_simulate/ucli.key \
  ./3_critical_location/input/critical_faults.sff \
  ./3_critical_location/input/feasible_faults.sff \
  ./4_fault_verification/DVEfiles \
)

foreach f ($outputFileList)
  if ( -e $f ) then
    rm -rf $f
  endif
end

cd 2_fault_sim/input
./clean.csh

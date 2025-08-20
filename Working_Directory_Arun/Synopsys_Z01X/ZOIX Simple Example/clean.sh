#!/bin/bash

# List of files and directories to remove
files_to_remove=(
    flops.txt
    sim.src
    zoix.log
    sim.zdb
    zoix.sim
    __ddbfiles__
    fault_report.log
    __fmdict__
    fmsh.log
    __fmsh__
    fr2fdef.log
    __fubs__
    __globfiles__
    sim.fdef
    user_coverage.sff
    testability.txt
    __tests__
    __tmp__
    sim.csrc
    zoix.sim.daidir
    *.log.*
    *.log
    cds.lib
    dictionary.sff
    *.fmd
    *.pass
    *.progress
    *fm*.vcd
    *.vpd
    DVEfiles
    ff.vcd
)

# Remove files and directories
for item in "${files_to_remove[@]}"; do
    rm -rf "$item"
done


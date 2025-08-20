#!/bin/csh -fe

# Compile extract_FF
# External script to auto-extract list of sequential devices for SEU faults
g++ $ZOIXHOME/share/extract_FF/extract_ff.cpp \
  -I $VERDI_HOME/share/NPI/inc \
  -I $VERDI_HOME/share/NPI/L1/C/inc \
  -L $VERDI_HOME/share/NPI/lib/linux64 \
  -L /usr/lib64/libz.a \
  -lz -lrt -ldl -lNPI -lnpiL1 \
  -o extract_FF

# Extract RTL flops given Verdi database
setenv LD_LIBRARY_PATH `echo $LD_LIBRARY_PATH`:$VERDI_HOME/share/NPI/lib/linux64
extract_FF -f run.f -sverilog -net -pathsonly -o flops.txt

set target_library [list sae32nm.v]         #.db file required for full synthesis with timing info, .v will only link
read_verilog saed32nm.v                

set top_module picorv32
read_verilog picorv32.v

elaborate $top_module

compile

write -format verilog -hierarchy -output picorv32_netlist.v

exit


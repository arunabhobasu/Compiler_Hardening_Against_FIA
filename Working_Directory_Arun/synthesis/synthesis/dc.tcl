####################################################
## File Name: dc.tcl
## File to setup libraries and synthesize design
## Created: 16 March 2017
## Usage:   dc_shell-xg-t -f dc.tcl |tee log
####################################################

set designer "Henian Li"
set company "University of Florida"

########################################################################################

set search_path [list "." "/apps/syn/32nm/lib/stdcell_rvt/db_nldm/"]
set target_library "/apps/syn/32nm/lib/stdcell_rvt/db_nldm/saed32rvt_tt1p05v25c.db"
set link_library "/apps/syn/32nm/lib/stdcell_rvt/db_nldm/saed32rvt_tt1p05v25c.db"

########################################################################################

set script_path "/home/UFAD/henian.li/Desktop/Multi-Fault_SoFI/AES128/synthesis/";   #### need to modify
set top "aes_128";                                  #### need to modify
set design_path $script_path[set temp3 "design/"];       #### need to modify

set work_d $script_path[set temp1 "work/"];   
define_design_lib work -path $work_d;

set dc_output_path $script_path[set temp2 "output/"];     
file mkdir $dc_output_path;

analyze {./design/} -autoread -recursive -format verilog -top $top

#foreach cell [list [ls [format "%s%s" $design_path "*.vhd"]]] \
#{read_vhdl $cell}

#for VHDL design
#read_vhdl [format "%s%s.vhdl" $design_path $top]

#set_flatten true

elaborate $top -update

current_design $top

link

uniquify

ungroup -flatten -all

check_design > $dc_output_path$top-check_design.log

set clk_signal clk

#create_clock -name TCK -period 100 -waveform [list 0 50] [get_port TCK]
create_clock -name $clk_signal -period 100 -waveform [list 0 50] [get_port $clk_signal]
#set_clock_latency 0.25 [get_clock $clk_signal]
#set_clock_transition 0.1 [get_clock $clk_signal]
#set_input_delay -max 0.5 [remove_from_collection [all_input] [get_port $clk_signal]] -clock [get_clock $clk_signal]
#set_output_delay -max 0.5 [all_output] -clock [get_clock $clk_signal]


#set_operating_conditions "tt1p05v25c" -library "saed32rvt_tt1p05v25c"
#set_wire_load_model -name "ForQA" -max -library "saed32rvt_tt1p05v25c"

#set fsm_auto_inferring true
#set fsm_export_formality_state_info true
#set_fsm_minimize false
#set_fsm_encoding_style binary
#set_fsm_state_vector {FSM_reg[2] FSM_reg[1] FSM_reg[0]}
#set_fsm_encoding {"WAIT_KEY=^B000" "WAIT_DATA=^B100" "INITIAL_ROUND=^B001" "DO_ROUND=^B010" "FINAL_ROUND=^B011"}
#set_fsm_order { WAIT_KEY INITIAL_ROUND DO_ROUND FINAL_ROUND WAIT_DATA}

#report_fsm

compile 

#report_fsm

#report_fsm > report_fsm.rpt

set verilogout_no_tri true
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

set verilogout_equation false
change_name -rule verilog -hierarchy

write_sdf -version 2.1 [format "%s%s_gate.sdf" $dc_output_path $top]
write_sdc [format "%s%s_gate.sdc" $dc_output_path $top]
write -format verilog -hierarchy -output [format "%s%s_gate.v" $dc_output_path $top]

report_cell > [format "%s%s_cell.txt" $dc_output_path $top]
report_area > [format "%s%s_area.txt" $dc_output_path $top]
report_timing > [format "%s%s_timing.txt" $dc_output_path $top]
report_power > [format "%s%s_power.txt" $dc_output_path $top]

exit

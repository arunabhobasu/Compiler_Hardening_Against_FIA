# Begin_DVE_Session_Save_Info
# DVE view(Wave.1 ) session
# Saved on Sun Nov 29 15:59:03 2020
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Wave.1: 8 signals
# End_DVE_Session_Save_Info

# DVE version: L-2016.06-SP2-9
# DVE build date: Sep 17 2017 21:13:36


#<Session mode="View" path="/ecel/UFAD/huanyuwang/Documents/Fault_Injection/Host_Demo/Demo/1_wave/session.wave.vcd.vpd.tcl" type="Debug">

#<Database>

gui_set_time_units 1ps
#</Database>

# DVE View/pane content session: 

# Begin_DVE_Session_Save_Info (Wave.1)
# DVE wave signals session
# Saved on Sun Nov 29 15:59:03 2020
# 8 signals
# End_DVE_Session_Save_Info

# DVE version: L-2016.06-SP2-9
# DVE build date: Sep 17 2017 21:13:36


#Add ncecessay scopes
gui_load_child_values {test.u0.dcnt_reg_1_}
gui_load_child_values {test.u0.done_reg}
gui_load_child_values {test.u0.dcnt_reg_3_}
gui_load_child_values {test.u0.dcnt_reg_0_}
gui_load_child_values {test.u0}
gui_load_child_values {test.u0.dcnt_reg_2_}

gui_set_time_units 1ps

set _wave_session_group_1 Group1
if {[gui_sg_is_group -name "$_wave_session_group_1"]} {
    set _wave_session_group_1 [gui_sg_generate_new_name]
}
set Group1 "$_wave_session_group_1"

gui_sg_addsignal -group "$_wave_session_group_1" { {V1:test.u0.clk} {V1:test.u0.rst} {V1:test.u0.ld} {V1:test.u0.done_reg.Q} {V1:test.u0.dcnt_reg_3_.Q} {V1:test.u0.dcnt_reg_2_.Q} {V1:test.u0.dcnt_reg_1_.Q} {V1:test.u0.dcnt_reg_0_.Q} }
if {![info exists useOldWindow]} { 
	set useOldWindow true
}
if {$useOldWindow && [string first "Wave" [gui_get_current_window -view]]==0} { 
	set Wave.1 [gui_get_current_window -view] 
} else {
	set Wave.1 [lindex [gui_get_window_ids -type Wave] 0]
if {[string first "Wave" ${Wave.1}]!=0} {
gui_open_window Wave
set Wave.1 [ gui_get_current_window -view ]
}
}

set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 474231 932813
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group1}]
gui_seek_criteria -id ${Wave.1} {Any Edge}

gui_list_alias -id ${Wave.1} -group ${Group1} -index 0 -signal V1:test.u0.done_reg.Q -add Done 
gui_list_alias -id ${Wave.1} -group ${Group1} -index 0 -signal V1:test.u0.dcnt_reg_3_.Q -add dcnt_reg_3 
gui_list_alias -id ${Wave.1} -group ${Group1} -index 0 -signal V1:test.u0.dcnt_reg_2_.Q -add dcnt_reg_2 
gui_list_alias -id ${Wave.1} -group ${Group1} -index 0 -signal V1:test.u0.dcnt_reg_1_.Q -add dcnt_reg_1 
gui_list_alias -id ${Wave.1} -group ${Group1} -index 0 -signal V1:test.u0.dcnt_reg_0_.Q -add dcnt_reg_0 

gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group ${Group1}  -position in

gui_marker_move -id ${Wave.1} {C1} 179
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false
#</Session>


1. Read wildcards (* or **) usage in ZOIX manual. Create a user.sff fault list with wildcards, run SoFI with this fault list. The user_coverage.sff will list all the involved signals.

2. Run cells_list_gen.py, it takes user_coverage.sff as input, and generate the "fault_list_cell.txt". It's the whole list of chosen signal names in the RTL codes, segmented by space.

2. Identify the fan-in vars of the critical vars defined in strobe.sv, the new list is "fault_list_cell_fanin.txt"
(To-do: Automate the fanin-reg identification, make fan-in depth configurable!)

3. Run sff_gen_RTL.py to get the .sff files for ZOIX. sff_gen_RTL.py takes cell list txt file as input (either a fanin list or not).

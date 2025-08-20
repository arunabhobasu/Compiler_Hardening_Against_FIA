#!/usr/bin/env python

from itertools import combinations as cb
import pandas as pd
import io
###########Parameter Definition###################

#module_name = 'aes_128'			            #Top module name of the design
fault_list_cells_file = "fault_list_cells_fanin.txt"              #File name of the fanin_cells
cycles = '(28:29)'                          #Cycles to inject faults
size = 4                                    #Number of maximum concurrent fault locations allowed
goal = 'seqt'                              #seqt, comb, all
CycleTime = '10000ps'                       #CycleTime
Offset = '2500ps'                           #Offset, 2500ps originally

##################################################
# Read text file
fanin_cells = list()

fid = open(fault_list_cells_file)
temp = fid.read()
#temp = temp.replace('{','\\')
#temp = temp.replace('}',' ')	
#fanin_cells = temp.replace('/D',' ').split()
fault_list_cells = temp.split()
fault_list_cells = list(set(fault_list_cells))    #Delete the duplicated elements
fid.close()

# Just for test
fid = open('test.txt','w')
for cell in fault_list_cells:
    fid.write(cell+' ')
fid.close()

#
comb = list()
seqt = list()
cell = list()
for i in range(0,len(fault_list_cells)):
    # If module_name does not start with a '\', delete the space in ' .Q'        
    pin = 'VARI "' + fault_list_cells[i] + '"'
    cell.append(pin)
    seqt.append(pin)

comb.sort()
seqt.sort(reverse=False)
cell.sort()

vcd_number = 1
vcd_period = 0

if goal == 'all':
    output_name = 'user_local_' + str(size) + '.sff'
elif goal == 'seqt':
    output_name = 'user_global_' + str(size) + '.sff'
elif goal == 'comb':
    output_name = 'user_comb_' + str(size) + '.sff'


sff = list()
sff.append('')
sff.append('FaultGenerate')
sff.append('{')
sff.append('    # Set timing for frequency of transient fault insertion')
line = '    Timing("cycle1", CycleTime ' + CycleTime + ', Offset ' + Offset + ')'
sff.append(line)
sff.append('')
sff.append('    # Create transient faults')


cycle_list = cycles.replace('(','').replace(')','').split(':')
start = int(cycle_list[0])
end = int(cycle_list[1])
step = end - start + 1 


if goal == 'all':
    target = cell
elif goal == 'seqt':
    target = seqt
elif goal == 'comb':
    target = comb
count = 0
#for i in range(1,len(target)+1):
for m in range(0,vcd_number):
    for i in range(1,size+1):
        comb = list(cb(target,i))
        l = start + vcd_period*(m)
        r = end + vcd_period*(m)
        l1 = list()
        for n in range(0,step):
            string = str(l+n) + '^' + str(l+n+1)
            l1.append(string)
        cycle_string = '(' + ', '.join(l1) + ')'
        for j in range(0,len(comb)):
            a = ' + '
            line = '    NA ~ ' + cycle_string + ' { ' + a.join(comb[j]) + ' }'
            sff.append(line)
            count += end-start+1    
    cycles = '(' + str(l) + ':' + str(r) + ')'

print('Total faults generated:')

print(count)


line = '}    #  Total Faults: ' + str(count)
sff.append(line)
sff.append('')
sff.append('Coverage')
sff.append('{')
sff.append('    "Security Property Violation Rate" = "(DD + OA)/(NA + DD + ND + OA)";')
sff.append('}')
sff.append('')


f = open(output_name, 'w')
for line in sff:
    f.write(line + '\n')
f.close()


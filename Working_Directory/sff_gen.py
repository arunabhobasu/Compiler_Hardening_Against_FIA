#!/usr/bin/env python
# coding: utf-8

from itertools import combinations as cb
#import pandas as pd
import io

###########Parameter Definition###################
file_name = "RSA_binary_v2.v"       #file name of the RTL design
cycles = '(5:7)'                            #Cycles to inject faults
size = 1                                    #number of maximum concurrent fault locations allowed
goal = 'seqt'                                #seqt, comb, all
CycleTime = '10000ps'                       #CycleTime
Offset = '2500ps'                           #Offset, should be 1/4 of the CycleTime


# To-do:
# 1. identify the reg vars, using the condition that there should not be any letter before or after "reg", 
# then such codes are really defining regs instead of some names included with "reg"s

# 2. real-reg identification. to choose the reg type vars are really becoming FFs during synthesis,
# can use large designs like avalon-aes to verify this

def read_txt(file_name):
    f = open(file_name)
    cnt_line = 0
    txt = list()
    while 1:
        txt.append(f.readline())
        if not txt[cnt_line]:
            break
        txt[cnt_line]=txt[cnt_line].replace("\n","")
        l=len(txt[cnt_line])
        if l > 0 and txt[cnt_line] != "endmodule" and txt[cnt_line].find('`timescale')==-1:
            if txt[cnt_line].find('//') > -1:
                cnt_line = cnt_line + 1
                continue
            while txt[cnt_line][len(txt[cnt_line]) - 1] != ";" :
                txt[cnt_line] = txt[cnt_line] + f.readline().strip()
        cnt_line = cnt_line + 1
    f.close()
    return txt


vcd_number = 1
vcd_period = 0

if goal == 'all':
    output_name = 'user_local_' + str(size) + '.sff'
elif goal == 'seqt':
    output_name = 'user_global_' + str(size) + '.sff'
elif goal == 'comb':
    output_name = 'user_comb_' + str(size) + '.sff'




netlist = read_txt(file_name)


module_name = ''
for i in range(0,len(netlist)):
    if netlist[i].find('module')>-1:
        module_name = netlist[i].split()[1]
        break

comb = list()
seqt = list()
cell = list()
for i in range(0,len(netlist)):
    if netlist[i].find('.')>-1 and netlist[i].find('//')==-1:
        pin = ''
        line = netlist[i].split()
        if line[0].find('DFF') > -1:
            pin = 'FLOP "' + module_name + '.' + line[1] + '.Q' + '"'
            cell.append(pin)
            seqt.append(pin)
        else:
            pin = 'PORT "' + module_name + '.' + line[1] + '.Y' + '"'
            cell.append(pin)
            comb.append(pin)
comb.sort()
seqt.sort(reverse=False)
cell.sort()


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




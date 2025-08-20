
# coding: utf-8

# In[1]:


from itertools import combinations as cb
import pandas as pd
import io
from collections import Counter


# In[2]:


def read_txt(file_name):
    f = open(file_name)
    cnt_line = 0
    txt = list()
    while 1:
        txt.append(f.readline())
        if not txt[cnt_line]:
            break
        txt[cnt_line]=txt[cnt_line].replace("\n","")
        cnt_line = cnt_line + 1
    f.close()
    return txt


# In[3]:


def find_cycle(line):
    time = line[line.find('(')+1:line.find(')')]
    cycle = list()
    time_list = time.split(', ')
    for i in range(0,len(time_list)):
        a = time_list[i].find(':')
        if a > -1:
            left = int(time_list[i][0:a])
            right = int(time_list[i][a+1:])
            for j in range(left,right+1):
                cycle.append(str(j))
        else:
            cycle.append(time_list[i])
    return(cycle)


# In[4]:


def find_port(line):
    left = line.find('{')+1
    right = line.find('}')
    fault = line[left:right]
    port = fault.split(' + ')
    for i in range(0,len(port)):
        if port[i].find('.Q')>-1:
            port[i]=port[i].replace('PORT','FLOP')
    return(port)


# In[5]:


def is_effective(t, cycle, location):
    if len(t) == 0:
        return(1)
    else:
        for i in range(0,len(t)):
            if t['Cycle'][i] == cycle:
                a = set(t['Location'][i].split(' + '))
                b = set(location)
                if a.issubset(b):
                    return(0)
        return(1)
                    


# In[6]:


coverage_file = "user_coverage.sff"
output_name = 'critical_faults.sff'


# In[7]:


coverage = read_txt(coverage_file)


# In[8]:


t = pd.DataFrame(columns=['Cycle', 'Location'])
count = 0
count_e = 0
for i in range(0,len(coverage)):
    point = coverage[i].find('~')
    if point > -1:
        status = coverage[i][point-3:point-1]
        if status == 'DD':
            cycle = find_cycle(coverage[i])
            location = find_port(coverage[i])
            count_e += len(cycle)
            for j in range(0,len(cycle)):
                ans = is_effective(t,cycle[j],location)
                #if ans == 1 or ans == 0:
                if ans == 1:
                    row = list()
                    row.append(cycle[j])
                    row.append(' + '.join(location))
                    t.loc[count] = row
                    count += 1


# In[9]:


total_faults = ''
for i in range(0,len(coverage)):
    if coverage[i].find('Faults listed:')>-1:
        total_faults = coverage[i].split()[-1]
        break
print(total_faults)


# In[10]:


def get_common(row,common):
    if row['Location'].find(common) > -1:
        return 'Y'
    else:
        return 'N'


# In[11]:


t1 = t
loc = list()
freq = list()
while len(t1) > 0:
    a = ' + '.join(t1['Location']).split(' + ')
    loc.append(Counter(a).most_common(1)[0][0])
    freq.append(Counter(a).most_common(1)[0][1])
    t1['Flag'] = t1.apply(get_common, common=loc[-1], axis = 1)
    t1 = t1[t1['Flag'] == 'N']


# In[12]:


report = list()
line = 'Total Faults: ' + total_faults
report.append(line)
line = 'Effective Faults: ' + str(count_e)
report.append(line)
line = 'Critical Faults: ' + str(count)
report.append(line)
report.append('')
for i in range(0,len(t)):
    line = '    NA ~ (' + t['Cycle'][i] + ') { ' + t['Location'][i] + ' }'
    report.append(line)
report.append('')
line = 'Critical Locations: ' +str(len(loc))
report.append(line)
report.append('')
for i in range(0,len(loc)):
    report.append('    ' + loc[i])


# In[13]:



f = open(output_name, 'w', newline='\n')
for line in report:
    f.write(line + '\n')
f.close()


# In[14]:


#t.to_excel("all_faults.xlsx")

# In[1]:


import pandas as pd
import matplotlib.pyplot as plt
import io
import re
from collections import Counter


# In[2]:


def read_txt(file_name):
    f = open(file_name)
    cnt_line = 0
    txt = list()
    while 1:
        txt.append(f.readline())
        if not txt[cnt_line]:
            break
        txt[cnt_line]=txt[cnt_line].replace("\n","")
        cnt_line = cnt_line + 1
    f.close()
    return txt


# In[3]:


def findnth(string, substring, n):
    parts = string.split(substring, n + 1)
    if len(parts) <= n + 1:
        return -1
    return len(string) - len(parts[-1]) - len(substring)


# In[4]:


vcd_name = "ff.vcd"
clk_cycle = 20
sff_name = "critical_faults.sff"
feasible_name = "feasible_faults.sff"


# In[5]:


vcd = read_txt(vcd_name)


# In[6]:


reg_dict = {}
module = ''
for i in range(0,len(vcd)):
    if vcd[i].find("$dumpvars")==0:
        break
    if vcd[i].find("$scope module ")==0 and len(module) == 0:
        a = findnth(vcd[i]," ",1)
        b = findnth(vcd[i]," ",2)
        module = vcd[i][a+1:b]
    if vcd[i].find("$var")==0:
        a = findnth(vcd[i]," ",2)
        b = findnth(vcd[i]," ",3)
        c = findnth(vcd[i]," ",4)
        symbol = vcd[i][a+1:b]
        port = vcd[i][b+1:c]
        a = findnth(vcd[i-1]," ",1)
        b = findnth(vcd[i-1]," ",2)
        cell = vcd[i-1][a+1:b]
        reg_dict[symbol] = module + '.'+ cell + "." + port
        


# In[8]:


t = pd.DataFrame(columns=['time','cycle','net','port','correct value','faulty value'])
time = []
cycle = []
net = []
port = []
value = []
fault = []
count = 0
current = -1
for i in range(0,len(vcd)):
    if vcd[i].find("#") == 0 and count < 1:
        count = count + 1
    elif vcd[i].find("#") == 0 and count == 1:
        current = vcd[i][1:-3]
        count = count + 1
    elif vcd[i].find("#") == 0 and count >= 2:
        current = vcd[i][1:-3]
    elif count >= 2 and vcd[i]!='':
        if reg_dict[vcd[i][1:len(vcd[i])]] == 'RSA_binary_v2.RSA_binary_v2.clk':
            continue
        time.append(int(current))
        cycle.append(int((int(current))/clk_cycle))
        value.append(int(vcd[i][0]))
        if vcd[i][0] == '0':
            fault.append(1)
        else:
            fault.append(0)
        symbol = vcd[i][1:len(vcd[i])]
        net.append(reg_dict[symbol])
        pt = reg_dict[symbol]
        port.append(pt)
t['time'] = time
t['cycle'] = cycle
t['net'] = net
t['port'] = port
t['correct value'] =value
t['faulty value'] = fault


# In[10]:


t_short = t.loc[t['time']<=3500]


# In[11]:


t_sort = t_short.sort_values(by=['net','time'],ascending=True).reset_index(drop=True)


# In[12]:


#t_short.to_excel("fault_time.xlsx")  
#t_sort.to_excel("fault_location.xlsx")  


# In[13]:


def feasible(cycle, port, T):
    a = T['cycle'] == int(cycle)
    b = T['port'] == port
    result = sum(a & b)
    return(result)


# In[14]:


sff = read_txt(sff_name)


# In[15]:


t_feasible = pd.DataFrame(columns=['Cycle', 'Location', 'L_Count'])
feasible_faults = []
for i in range(0,len(sff)):
    if sff[i].find('~')>=0:
        left = sff[i].find('(')
        right = sff[i].find(')')
        cycle = sff[i][left+1:right]
        left = sff[i].find('{')
        right = sff[i].find('}')
        port_txt = sff[i][left+2:right-1]
        port_list = port_txt.replace('FLOP ','').replace('"','').split(' + ')
        feasible_count = 0
        for j in range(0,len(port_list)):
            feasible_count += feasible(cycle,port_list[j],t)
        if feasible_count == len(port_list):
            feasible_faults.append(i)
            row = list()
            row.append(cycle)
            row.append(port_txt)
            row.append(len(port_list))
            t_feasible.loc[len(feasible_faults)] = row
feasible_faults_count = len(feasible_faults)
print(feasible_faults_count)


# In[16]:



def get_common(row,common):
    if row['Location'].find(common) > -1:
        return 'Y'
    else:
        return 'N'


# In[17]:


loc = list()
freq = list()
loc_count = list()
t = t_feasible
for i in range(1, max(t['L_Count'])+1):
    t1 = t[t['L_Count']==i]
    if len(t1) == 0:
        loc_count.append(str(len(loc)))
        continue
    for j in range(0,len(loc)):
        t1['Flag'] = t1.apply(get_common, common=loc[j], axis = 1)
        t1 = t1[t1['Flag'] == 'N']
    while len(t1) > 0:
        a = ' + '.join(t1['Location']).split(' + ')
        loc.append(Counter(a).most_common(1)[0][0])
        freq.append(Counter(a).most_common(1)[0][1])
        t1['Flag'] = t1.apply(get_common, common=loc[-1], axis = 1)
        t1 = t1[t1['Flag'] == 'N']
    loc_count.append(str(len(loc)))


# In[18]:


sff = read_txt(sff_name)
line = 'Feasible Faults: ' + str(feasible_faults_count)
sff.append(line)
sff.append('')
for i in range(0,len(feasible_faults)):
    sff.append(sff[feasible_faults[i]])
sff.append('')


# In[19]:


line = 'Critical Locations: ' +str(len(loc))
sff.append(line)
sff.append('')
for i in range(0,len(loc)):
    sff.append('    ' + loc[i])


# In[20]:


f = open(feasible_name, 'w', newline='\n')
for line in sff:
    f.write(line + '\n')
f.close()


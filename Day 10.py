# -*- coding: utf-8 -*-
"""
Created on Sat Dec 10 16:10:59 2022

@author: Zoe
"""


def next_cycle(cycle):
    cycle += 1
    if cycle in interesting:
        cycle_list.append(regX)

    return cycle
        
#Part 1------------------------------------------------------------------------
cycle = 0
cycle_list = list()
regX = 1
interesting = [20, 60, 100, 140, 180, 220]

with open("Day 10.txt","r") as indata:
    for command in indata:
        if command[0:4] == "noop":
            cycle = next_cycle(cycle)
        else:
            cycle = next_cycle(cycle)
            cycle = next_cycle(cycle)
            regX += int(command[5:].strip())
            
del indata, command

for x in range(len(cycle_list)):
    cycle_list[x] = cycle_list[x]*interesting[x]
    del x
answer1 = sum(cycle_list)

#Part 2------------------------------------------------------------------------

def drawpix(cycle):
    print(((cycle-1)%40,regX))
    if abs((cycle-1)%40 - regX) <= 1:
        return "#"
    else:
        return "."
cycle = 0
cycle_list = list()
regX = 1
crt = ""
with open("Day 10.txt","r") as indata:
    for command in indata:
        if command[0:4] == "noop":
            cycle = next_cycle(cycle)
            crt = crt + drawpix(cycle)
        else:
            cycle = next_cycle(cycle)
            crt = crt + drawpix(cycle)
            cycle = next_cycle(cycle)
            crt = crt + drawpix(cycle)
            regX += int(command[5:].strip())

#Copy crt into notepad and adjust window width until there are 6 lines.
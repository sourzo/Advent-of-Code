# -*- coding: utf-8 -*-
"""
Created on Tue Jan  3 14:51:07 2023

@author: Zoe
"""
monkeydict = dict()
monkeyops = dict()
with open("Day 21.txt","r") as indata:
    for line in indata:
        linelist = line.strip().split()
        if len(linelist) == 2:
            monkeydict[linelist[0][0:4]] = int(linelist[1])
        else:
            monkeyops[linelist[0][0:4]] = linelist[1:4]
del indata, line, linelist

monkeyops2 = monkeyops.copy()

while "root" not in monkeydict:
    for key, val in monkeyops.items():
        if val[0] in monkeydict and val[2] in monkeydict:
            if val[1] == "+":
                monkeydict[key] = monkeydict[val[0]] + monkeydict[val[2]]
            elif val[1] == "-":
                monkeydict[key] = monkeydict[val[0]] - monkeydict[val[2]]
            elif val[1] == "*":
                monkeydict[key] = int(monkeydict[val[0]] * monkeydict[val[2]])
            elif val[1] == "/":
                monkeydict[key] = int(monkeydict[val[0]] / monkeydict[val[2]])
            monkeyops2.pop(key)
    monkeyops = monkeyops2.copy()

del monkeyops, monkeyops2, val, key
print(monkeydict["root"])


# -*- coding: utf-8 -*-
"""
Created on Tue Jan  3 14:51:07 2023

@author: Zoe
"""
#Part 2 requires the SymPy package to solve an equation
import sympy
from sympy.abc import x, y
from sympy import solve


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

#Part 2-----------------------------------------------------
monkeydict = dict()
monkeyops = dict()
with open("Day 21.txt","r") as indata:
    for line in indata:
        linelist = line.strip().split()
        if len(linelist) == 2:
            monkeydict[linelist[0][0:4]] = linelist[1]
        else:
            monkeyops[linelist[0][0:4]] = linelist[1:4]
del indata, line, linelist
monkeydict["humn"] = "x"
monkeyops["root"][1] = "=="
monkeyops2 = monkeyops.copy()

#Create an expression with the number to be shouted by the human as "x"
while "root" not in monkeydict:
    for key, val in monkeyops.items():
        if val[0] in monkeydict and val[2] in monkeydict:
            print(val[0], val[2])
            print(val[0].isdigit(), val[2].isdigit())
            #evaluate numerical expressions
            if monkeydict[val[0]].isdigit() and monkeydict[val[2]].isdigit():
                if val[1] == "+":
                    monkeydict[key] = str(int(monkeydict[val[0]]) + int(monkeydict[val[2]]))
                elif val[1] == "-":
                    monkeydict[key] = str(int(monkeydict[val[0]]) - int(monkeydict[val[2]]))
                elif val[1] == "*":
                    monkeydict[key] = str(int(int(monkeydict[val[0]]) * int(monkeydict[val[2]])))
                elif val[1] == "/":
                    monkeydict[key] = str(int(int(monkeydict[val[0]]) / int(monkeydict[val[2]])))
                elif val[1] == "==":
                    #Root: instead of a == b, put a - b (=0)
                    monkeydict[key] = "".join(["(", monkeydict[val[0]], "-", monkeydict[val[2]], ")"])
            #print non-numerical expressions as strings:
            else:
                if key == "root":
                    #Root: instead of a == b, put a - b (=0)
                    monkeydict[key] = "".join(["(", monkeydict[val[0]], "-", monkeydict[val[2]], ")"])
                else:
                    monkeydict[key] = "".join(["(",monkeydict[val[0]],val[1],monkeydict[val[2]],")"])
            monkeyops2.pop(key)
    monkeyops = monkeyops2.copy()
    
#monkeydict["root"] is an expression to be solved for x. 

#Use an equation solver to find x
print(solve(eval(monkeydict["root"]), dict=True))
# -*- coding: utf-8 -*-
"""
Created on Mon Dec  5 09:41:42 2022

@author: Zoe
"""

crates_test = [["Z","N"],
                   ["M","C","D"],
                   ["P"]]
crates = [["W","R","F"],
              ["T","H","M","C","D","V","W","P"],
              ["P","M","Z","N","L"],
              ["J","C","H","R"],
              ["C","P","G","H","Q","T","B"],
              ["G","C","W","L","F","Z"],
              ["W","V","L","Q","Z","J","G","C"],
              ["P","N","R","F","W","T","V","C"],
              ["J","W","H","G","R","S","V"]]

import pandas as pd
instructions = pd.read_csv("Day 5b.txt", sep=" ", header=None)
instructions = instructions.iloc[:,[1,3,5]]
instructions.columns=["move","from","to"]

#fix indices
instructions["from"] = instructions["from"]-1
instructions["to"] = instructions["to"]-1

#CrateMover 9000 (Part 1)
#for index, row in instructions.iterrows():
#    for move in range(row["move"]):
#        #add a crate to new stack
#        crates[row["to"]].append(crates[row["from"]][-1])
#        #remove the crate from old stack
#        crates[row["from"]].pop(-1)
        
#CrateMover 9001 (Part 2)
for index, row in instructions.iterrows():
    fromStack = row["from"]
    toStack = row["to"]
    moveNum = row["move"]
    #add crates to new stack
    crates[toStack].extend(crates[fromStack][len(crates[fromStack]) - moveNum : 
                                                 len(crates[fromStack])
                                                 ]
                             )
    #remove the crates from old stack
    crates[fromStack] = crates[fromStack][:len(crates[fromStack])-moveNum]

answer = ""
for stack in crates:
    answer = answer + stack[-1]

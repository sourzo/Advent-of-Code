# -*- coding: utf-8 -*-
"""
Created on Sun Dec  4 10:12:14 2022

@author: Zoe
"""

#Overlapping & conclave intervals

import pandas as pd

indata = pd.read_csv("Day 4.csv", header = None)
indata.set_axis(['elf1', 'elf2'], axis='columns', inplace=True)


#Create sets of integers in the specified intervals
#int1 for elf1 and int2 for elf2
indata["int1char"] = indata["elf1"].apply(lambda x : x.split("-"))
indata["int2char"] = indata["elf2"].apply(lambda x : x.split("-"))

int1 = list(indata["int1char"].apply(lambda x : set(range(int(x[0]), 
                                                               int(x[1])+1))
                                     )
            )
int2 = list(indata["int2char"].apply(lambda x : set(range(int(x[0]), 
                                                               int(x[1])+1))
                                     )
            )

intersection = []
complete_overlap = 0
any_overlap = 0
for index in range(len(int1)):
    intersection.append(int1[index] & int2[index])
    if len(intersection[index]) in (len(int1[index]), len(int2[index])):
        complete_overlap = complete_overlap + 1
    if len(intersection[index]) > 0:
        any_overlap = any_overlap + 1

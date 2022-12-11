# -*- coding: utf-8 -*-
"""
Created on Sun Dec 11 10:55:45 2022

@author: Zoe
"""
        
#Manually inputting data because there's not much!
items_test = [[79,98],
              [54, 65, 75, 74],
              [79, 60, 97],
              [74]]

def operation_test(monkey, old):
    if monkey == 0:
        new = old * 19
    elif monkey == 1:
        new = old + 6
    elif monkey == 2:
        new = old * old
    elif monkey == 3:
        new = old + 3
    return new

conditions_test = [23,19,13,17]
throwtrue_test = [2,2,1,0]
throwfalse_test = [3,0,3,1]




def operation(monkey, old):
    if monkey == 0:
        new = old * 3
    elif monkey == 1:
        new = old + 8
    elif monkey == 2:
        new = old + 2
    elif monkey == 3:
        new = old + 4
    elif monkey == 4:
        new = old * 19
    elif monkey == 5:
        new = old + 5
    elif monkey == 6:
        new = old * old
    elif monkey == 7:
        new = old + 1
    return new

conditions = [5,11,2,13,7,3,17,17]
throwtrue = [2,4,5,1,7,4,0,6]
throwfalse = [3,7,3,5,6,1,2,0]
import math
import numpy

#Part 1-----------------------------------------------------------------------
inspection_count=[0,0,0,0,0,0,0,0]
items = [[65, 78],
         [54, 78, 86, 79, 73, 64, 85, 88],
         [69, 97, 77, 88, 87],
         [99],
         [60, 57, 52],
         [91, 82, 85, 73, 84, 53],
         [88, 74, 68, 56],
         [54, 82, 72, 71, 53, 99, 67]]

for rounds in range(20):
    for monkey in range(8):
        while len(items[monkey]) > 0:
            worry = items[monkey][0]
            worry = operation(monkey, worry)
            worry = math.floor(worry/3)
            if worry%conditions[monkey] == 0:
                items[throwtrue[monkey]].append(worry)
                items[monkey].pop(0)
            else:
                items[throwfalse[monkey]].append(worry)
                items[monkey].pop(0) 
            inspection_count[monkey] = inspection_count[monkey] + 1

#Part 2-----------------------------------------------------------------------
inspection_count=[0,0,0,0,0,0,0,0]

items = [[65, 78],
         [54, 78, 86, 79, 73, 64, 85, 88],
         [69, 97, 77, 88, 87],
         [99],
         [60, 57, 52],
         [91, 82, 85, 73, 84, 53],
         [88, 74, 68, 56],
         [54, 82, 72, 71, 53, 99, 67]]

for rounds in range(10000):
    for monkey in range(8):
        while len(items[monkey]) > 0:
            worry = items[monkey][0]
            worry = operation(monkey, worry)
            worry = worry%(math.prod(conditions))
            if worry%conditions[monkey] == 0:
                items[throwtrue[monkey]].append(worry)
                items[monkey].pop(0)
            else:
                items[throwfalse[monkey]].append(worry)
                items[monkey].pop(0) 
            inspection_count[monkey] = inspection_count[monkey] + 1

inspection_count.sort()
answer2 = inspection_count[6]*inspection_count[7]

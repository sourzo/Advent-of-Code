# -*- coding: utf-8 -*-
"""
Created on Sat Dec  3 12:58:52 2022

@author: Zoe
"""
#Part 1: Highest calorie count

indata = open("Day 1.txt","r")
cal_count = 0
highest_cal = 0
for item in indata:
    if len(item.strip()) == 0:
        highest_cal = max(highest_cal, cal_count)
        cal_count = 0
    else:
        cal_count = cal_count + int(item)
indata.close()

#final value
highest_cal = max(highest_cal, cal_count)
del cal_count, indata, item

#Part 2: Total calorie count from the 3 elves with the most calories

indata = open("Day 1.txt","r")
cal_count = 0
highest_cal_list = [0,0,0]
for item in indata:
    if len(item.strip()) == 0:
        #add new value to list of three highest
        compare = highest_cal_list + [cal_count]
        #sort by size and pick the three highest
        compare.sort()
        highest_cal_list = compare[1:4]
        #reset calorie count
        cal_count = 0
    else:
        cal_count = cal_count + int(item)
indata.close()

#final value
#add new value to list of three highest
compare = highest_cal_list + [cal_count]
#sort by size and pick the three highest
compare.sort()
highest_cal_list = compare[1:4]

del cal_count, indata, item, compare
d1p2 = sum(highest_cal_list)

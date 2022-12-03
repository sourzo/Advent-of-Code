# -*- coding: utf-8 -*-
"""
Created on Sat Dec  3 14:59:52 2022

@author: Zoe
"""
#Part 1
import string
priority = list(string.ascii_letters)

priority_sum = 0
indata = open("Day 3.txt","r")

for rucksack in indata:
    item_count = int(len(rucksack.strip())/2)
    #split the items in two. Split the strings into sets.
    pocket1 = set(rucksack[0:item_count])
    pocket2 = set(rucksack[item_count:len(rucksack.strip())])
    #find the intersection of the two sets (pockets)
    intersection = list(pocket1 & pocket2)
    #find the priority (index + 1) of the item appearing in both pockets
    priority_sum = priority_sum + priority.index(intersection[0]) + 1
    
indata.close()
del rucksack, indata, item_count, intersection, pocket1, pocket2, priority


#Part 2
import string
priority = list(string.ascii_letters)

indata = open("Day 3.txt","r")
count = 2
group = [{},{},{}]
priority_sum = 0

for rucksack in indata:
    count = (count + 1) % 3
    group[count] = set(rucksack.strip())
    if count == 2:
        intersection = list(group[0] & group[1] & group[2])
        print(intersection)
        group = [{},{},{}]
        priority_sum = priority_sum + priority.index(intersection[0]) + 1
        
indata.close()
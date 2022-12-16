# -*- coding: utf-8 -*-
"""
Created on Wed Dec 14 18:26:34 2022

@author: Zoe
"""
message = list()
with open("Day 13.txt","r") as indata:
    for line in indata:
        if line.strip() != "":
            message.append(eval(line.strip()))
del indata, line

def compare(obj1, obj2):
    if type(obj1) == int:
        obj1 = [obj1]
    if type(obj2) == int:
        obj2 = [obj2]
    for x in range(len(obj1)):
        if x >= len(obj2):
            return False
        #integer to integer
        elif type(obj1[x]) == int and type(obj2[x]) == int:
            if obj1[x] < obj2[x]:
                #print("Outcome 1a")
                return True
            elif obj1[x] > obj2[x]:
                #print("Outcome 1b")
                return False
        #list to list, or mix
        else:
            #print("Outcome 2")
            if compare(obj1[x], obj2[x]) is not None:
                return compare(obj1[x], obj2[x])

    #run out of items in obj1
    if len(obj1) < len(obj2):
        #print("Outcome 3a")
        return True
    elif len(obj1) > len(obj2):
        #print("Outcome 3b")
        return False
        
count = 0
answer1 = 0
for y in range(0,len(message),2):
    count = count + 1
    print(compare(message[y],message[y+1]))
    if compare(message[y],message[y+1]) == True:
        answer1 = answer1 + count
del count, y

count_2 = 1
count_6 = 2
for x in range(len(message)):
    print(message[x])
    print(compare(message[x],[[2]]))
    print(compare(message[x],[[6]]))
    if compare(message[x],[[2]]) == True:
        count_2 = count_2 + 1
        count_6 = count_6 + 1
    elif compare(message[x],[[6]]) == True:
        count_6 = count_6 + 1
        
answer2 = count_2*count_6

# -*- coding: utf-8 -*-
"""
Created on Tue Dec  6 12:52:27 2022

@author: Zoe
"""

indata = open("Day 6.txt","r")

for item in indata:
    for letters in range(len(item)):
        if len(set(item[letters:letters+4])) == 4:
            print(letters+4)
            break

for item in indata:
    for letters in range(len(item)):
        if len(set(item[letters:letters+14])) == 14:
            print(letters+14)
            break

indata.close()
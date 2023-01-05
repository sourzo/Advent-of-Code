# -*- coding: utf-8 -*-
"""
Created on Tue Jan  3 16:59:41 2023

@author: Zoe
"""
def snafu_to_dec(s):
    total = 0
    exp = 0
    for x in s[::-1]:
        if x == "=":
            #-2
            total += (5**exp)*(-2)
        elif x == "-":
            total += (5**exp)*(-1)
        else:
            total += (5**exp)*(int(x))
        exp += 1
    del x
    return total
    
grandtotal = 0
with open("Day 25.txt","r") as indata:
    for line in indata:
        grandtotal += snafu_to_dec(line.strip())
del indata, line

#Convert decimal to snafu

snafu_digits = ["=","-","0","1","2"]

snafu = ""

remainder = grandtotal
exp = 0
while 3*(5**exp) < remainder:
    exp += 1

while exp >= 0:    
    min_rem = abs(remainder)
    for get_n in [-2,-1,0,1,2]:
        if abs(remainder - get_n*(5**exp)) <= min_rem:
            min_rem = abs(remainder - get_n*(5**exp))
            n = get_n
    del get_n, min_rem
    snafu = snafu + snafu_digits[n+2]
    remainder = remainder - n*(5**exp)
    exp -= 1
del exp, n, remainder, snafu_digits

#test
if snafu_to_dec(snafu) == grandtotal:
    print("Success!")
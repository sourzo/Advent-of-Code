# -*- coding: utf-8 -*-
"""
Created on Tue Jan  3 12:39:25 2023

@author: Zoe
"""

seq = list()
with open("Day 20 test.txt","r") as indata:
    for line in indata:
        seq.append(int(line.strip()))
del line, indata
seq2 = seq.copy()

#note entries are not unique:
len(set(seq))

keep_track = ["x"]*len(seq)

L = len(seq)-1

def move_number(startlist, old_pos):
    n = startlist[old_pos]
    new_pos = (old_pos + n)%L
    if new_pos == 0 and old_pos != 0:
        new_pos = L
    startlist.pop(old_pos)
    startlist.insert(new_pos, n)
    keep_track.pop(old_pos)
    keep_track.insert(new_pos, "o")


count = 0
maxloop = len(seq)
while "x" in keep_track and count <= maxloop:
    count = count + 1
    print(count)
    move_number(seq, keep_track.index("x"))

print("Answer:")
print(sum([seq[(seq.index(0) + 1000)%len(seq)],
      seq[(seq.index(0) + 2000)%len(seq)],
      seq[(seq.index(0) + 3000)%len(seq)]]))

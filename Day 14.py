# -*- coding: utf-8 -*-
"""
Created on Fri Dec 16 16:14:16 2022

@author: Zoe
"""
# Coordinates are the wrong way round, 
# but the coordinates here are internally consistent
# so it works fine
#  "vertical" = to the right;
#  "down and left" = right and up
#  "down and right" = right and down

import numpy as np

#Get input data
coords = list()
with open("Day 14.txt","r") as indata:
    for line in indata:
        line = line.strip()
        coords.append(line.split(" -> "))
del line, indata

max_x = 0
max_y = 0
for path in range(len(coords)):
    for pair in range(len(coords[path])):
        coords[path][pair] = coords[path][pair].split(",")
        coords[path][pair][0] = int(coords[path][pair][0])
        coords[path][pair][1] = int(coords[path][pair][1])
        max_x = max(max_x, coords[path][pair][0])
        max_y = max(max_y, coords[path][pair][1])
del pair, path

#draw paths
wall = np.full((max_x+500,max_y+2),".")
for path in range(len(coords)):
    for pair in range(len(coords[path])-1):
        x1 = coords[path][pair][0]
        y1 = coords[path][pair][1]
        x2 = coords[path][pair+1][0]
        y2 = coords[path][pair+1][1]
        if x1 - x2 == 0:
            for y in range(min(y1,y2), max(y1, y2)+1):
                wall[x1,y] = "#"
        elif y1 - y2 == 0:
            for x in range(min(x1,x2), max(x1, x2)+1):
                wall[x,y1] = "#"
        
del max_x, path, pair, x1, x2, y1, y2, x, y

def fall(x,y):
    xpos = x
    ypos = y
    while ypos < max_y:
        #vertical drop (on AoC drawing)
        if wall[xpos,ypos+1] == ".":
            ypos = ypos + 1
        #down and left (on AoC drawing)
        elif wall[xpos-1, ypos+1] == ".":
            xpos = xpos - 1
            ypos = ypos + 1
        #down and right (on AoC drawing)
        elif wall[xpos+1, ypos+1] == ".":
            xpos = xpos + 1
            ypos = ypos + 1
        #comes to rest
        else:
            return xpos, ypos
    #falls forever
    return 1000, 1000



count = 0
stop = 0
while stop == 0:
    x,y = fall(500,0)
    if y<1000:
        wall[x,y] = "o"
        count = count + 1
    else:
        stop = 1
    
#Part 2
def fall2(x,y):
    xpos = x
    ypos = y
    while ypos < max_y+1:
        #vertical drop (on AoC drawing)
        if wall[xpos,ypos+1] == ".":
            ypos = ypos + 1
        #down and left (on AoC drawing)
        elif wall[xpos-1, ypos+1] == ".":
            xpos = xpos - 1
            ypos = ypos + 1
        #down and right (on AoC drawing)
        elif wall[xpos+1, ypos+1] == ".":
            xpos = xpos + 1
            ypos = ypos + 1
        #comes to rest
        else:
            return xpos, ypos
    #hits the bottom
    return xpos, ypos

count2 = count
stop = 0
while stop == 0:
    x,y = fall2(500,0)
    wall[x,y] = "o"
    count2 = count2 + 1
    if x == 500 and y == 0:
        stop = 1

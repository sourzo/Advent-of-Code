# -*- coding: utf-8 -*-
"""
Created on Mon Dec 19 17:11:44 2022

@author: Zoe
"""
#possible problem: bits on the very outside
import pandas as pd
#input as list of lists
set_coords = set()
with open("Day 18 test.csv", "r") as indata:
    for line in indata:
        set_coords.add(eval("("+line.strip()+")"))
del indata, line

#each line is the position of a 1x1x1 cube making up part of a lava droplet
#need to find surface area
#projections from 6 angles?
indata = pd.read_csv("Day 18 test.csv")
indata.columns = ["x","y","z"]

coords_max = [indata["x"].max() + 2, indata["y"].max() + 2, indata["z"].max() + 2]
coords_min = [indata["x"].min() - 1, indata["y"].min() - 1, indata["z"].min() - 1]

#Need to "fill in" the inside cubes of this thing, 
#can add these cubes to the list of coordinates for the block
#but first need to count outside cubes, then all others not listed are inside

outside = set([(0,0,0)])
old_length = 0
#list outside cubes
while len(outside) != old_length:
    old_length = len(outside)
    for x in range(coords_min[0],coords_max[0]):
        for y in range(coords_min[1],coords_max[1]):
            for z in range(coords_min[2],coords_max[2]):
                if (x,y,z) not in set_coords and (x,y,z) not in outside:
                    if any([(x-1,y,z) in outside, (x+1,y,z) in outside,
                            (x,y-1,z) in outside, (x,y+1,z) in outside, 
                            (x,y,z-1) in outside, (x,y,z+1) in outside]):
                        outside.add((x,y,z))

#now fill in any cubes which aren't listed as outside cubes
test = set()
for x in range(coords_max[0]):
    for y in range(coords_max[1]):
        for z in range(coords_max[2]):
            if (x,y,z) not in outside and (x,y,z) not in set_coords:
                set_coords.add((x,y,z))

del x, y, z, old_length

#put into data frame
indata = pd.DataFrame(set_coords, columns =["x","y","z"])


def count_plane(a,b,c):
    test = indata.sort_values([a,b,c])
    test = test.reset_index(drop=True)

    coords = {"x" : -1,
              "y" : -1,
              "z" : -1}
    count = 0
    
    for i, r in test.iterrows():
        if r[a] != coords[a] and r[b] != coords[b]:
            coords[a] = r[a]
            coords[b] = r[b]
            count = count + 1
        elif test.loc[i,c] != test.loc[i-1,c] + 1:
                count = count + 1
    
    return count

ans1 = 2*sum([count_plane("x","y","z"),
             count_plane("z","y","x"),
             count_plane("x","z","y")])







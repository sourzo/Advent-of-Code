# -*- coding: utf-8 -*-
"""
Created on Sat Dec 17 18:31:13 2022

@author: Zoe
"""
#Get list of coordinates of beacons and sensors
#1st coordinate is horizontal
#2nd coordinate is vertical

sensors = list()
beacons = list()
target_line = 10
with open("Day 15.txt", "r") as indata:
    for line in indata:
        line = line.strip()
        instructions = line.split(sep=" ")
        for n in [0, 0, 2, 2, 2, 2]:
            instructions.pop(n)
        for n in range(3):
            instructions[n] = instructions[n][2:len(instructions[n])-1]
        instructions[3] = instructions[3][2:len(instructions[3])]
        sensors.append(instructions[0:2])
        sensors[-1][0] = int(sensors[-1][0])
        sensors[-1][1] = int(sensors[-1][1])
        beacons.append(instructions[2:4])
        beacons[-1][0] = int(beacons[-1][0])
        beacons[-1][1] = int(beacons[-1][1])

#find dimensions of tunnel network
x_min = int()
y_min = int()
x_max = int()
y_max = int()

for n in range(len(beacons)):
    x_min = min(x_min, beacons[n][0])
    y_min = min(y_min, beacons[n][1])
    x_max = max(x_max, beacons[n][0])
    y_max = max(y_max, beacons[n][1])
del indata, line, instructions, n

#find taxicab distances between each sensor and its closest beacon
distances = list()
for n in range(len(beacons)):
    distances.append(
        abs(beacons[n][0] - sensors[n][0]) + abs(beacons[n][1] - sensors[n][1])
        )
del n

set_of_points = set()
for sensor in range(len(sensors)):
    hor_dist = distances[sensor] - abs(sensors[sensor][1] - target_line)
    if hor_dist > 0:
        interval_min = sensors[sensor][0] - hor_dist
        interval_max = sensors[sensor][0] + hor_dist
        for s in range(interval_min, interval_max):
            set_of_points.add(s)
del sensor, hor_dist, interval_min, interval_max, s, target_line

#Part 2

#the beacon must be next to a boundary, so instead of putting all covered points
#into set_of_points, which is worst-case 4,000,000 points added 29 times for each line,

import portion as p

size = 4000000

for target_line in range(4000000):
    if target_line%100000 == 0:
        print(target_line)
    scanned = p.empty()
    for sensor in range(len(sensors)):
        hor_dist = distances[sensor] - abs(sensors[sensor][1] - target_line)
        if hor_dist > 0:
            interval_min = max(0, sensors[sensor][0] - hor_dist)
            interval_max = min(size, sensors[sensor][0] + hor_dist)
            scanned = scanned | p.closed(interval_min, interval_max)
    if len(scanned) == 2:
        print(scanned)
        distress_y = target_line
        break

distress_x = scanned[0].upper + 1
del sensor, hor_dist, interval_min, interval_max, target_line
tuning_freq = distress_x*4000000 + distress_y

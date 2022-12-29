# -*- coding: utf-8 -*-
"""
Created on Sat Dec 17 23:20:52 2022

@author: Zoe
"""
#Create flow_rates - list of valves and flow rates
#Create neighbours - list of valves and neighbouring valves
flow_rates = dict()
neighbours = dict()
with open("Day 16.txt", "r") as indata:
    for line in indata:
        line = line.strip().split()
        flow_rates[line[1]] = int(line[4][5:-1])
        neighbours[line[1]] = line[9:]
        for x in range(len(neighbours[line[1]])):
            neighbours[line[1]][x] = neighbours[line[1]][x][0:2]

#list all valves
del indata, line, x
valve_names = list()
for valve in neighbours:
    valve_names.append(valve)
del valve

#create distance matrix for flow_rates
#use BFS
#use valve_names for indexing this distance matrix
import numpy as np

distmat = np.zeros((len(neighbours),len(neighbours)))

def get_distances(start):
    queue = list()
    queue.append(start)
    distances = {start: 0}
    while len(queue) > 0:
        for x in neighbours[queue[0]]:
            if x not in distances:
                queue.append(x)
                distances[x] = distances[queue[0]]+1
        queue.pop(0)
    return distances

for start in valve_names:
    dist = get_distances(start)
    for valve in dist:
        distmat[valve_names.index(start),
                valve_names.index(valve)] = dist[valve]

del dist, start, valve

#list all valves with nonzero flow
unopened_valves = list()
for x in flow_rates:
    if flow_rates[x] != 0:
        unopened_valves.append(x)
del x

#Backtracking - using recursion

max_pressure = 0
def open_valve(unopened, opened, pressure, time):
    global max_pressure
    for next in unopened:
        new_unopened_list = [x for x in unopened if x != next]
        new_opened_list = opened + [next]
        new_time = time + distmat[valve_names.index(new_opened_list[-1]),
                                  valve_names.index(new_opened_list[-2])]
        if new_time < 30:
            #open the valve
            new_time = new_time + 1
            #pressure changes
            new_pressure = pressure + int((30-new_time)*flow_rates[next])

        else:
            new_unopened_list = []
            new_pressure = pressure

        if len(new_unopened_list) == 0:
            max_pressure = max(max_pressure, new_pressure)
            print(new_opened_list, max_pressure, new_pressure, new_time)

        else:
            open_valve(new_unopened_list, new_opened_list, new_pressure, new_time)

    return max_pressure

open_valve(unopened_valves, ["AA"], 0, 0)

#Part 2 - Human and elephant working in tandem, max time 26 min---------------------------------------------------------

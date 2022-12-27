# -*- coding: utf-8 -*-
"""
Created on Sat Dec 17 23:20:52 2022

@author: Zoe
"""
import math
flow_rates = dict()
neighbours = dict()
with open("Day 16.txt","r") as indata:
    for line in indata:
        line = line.strip().split()
        flow_rates[line[1]] = int(line[4][5:-1])
        neighbours[line[1]] = line[9:]
        for x in range(len(neighbours[line[1]])):
            neighbours[line[1]][x] = neighbours[line[1]][x][0:2]

#list all tunnel names
del indata, line, x
valve_names = list()
for valve in neighbours:
    valve_names.append(valve)
del valve

#create distance matrix for flow_rates
#use BFS
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

#calculate potential flow at time t
#def calculate_potential(current_valve, current_time):
#    future_flow = dict()
#    for valve in flow_rates:
#        future_flow[valve] = int((30 - (distmat[valve_names.index(current_valve), valve_names.index(valve)] + 1 + current_time)) * flow_rates[valve])
#    return future_flow
#test = calculate_potential("DD",2)
# === maybe want to only include valves not already open?

#def calculate_total(current_valve, next_valve, current_time):
#    return int((30 - (distmat[valve_names.index(current_valve), valve_names.index(next_valve)] + 1 + current_time)) * flow_rates[next_valve])

#list all valves with nonzero flow
unopened_valves = list()
for x in flow_rates:
    if flow_rates[x] != 0:
        unopened_valves.append(x)
del x

def create_path(best, valve_order):
    pressure = 0
    time = 0
    current_valve = "AA"
    for x in valve_order:
        #go to the valve
        time = time + distmat[valve_names.index(current_valve),
                              valve_names.index(x)]
        #open the valve
        time = time + 1        
        #pressure changes
        pressure = pressure + int((30-time)*flow_rates[x])
        #new current valve
        current_valve = x
    best = max(best, pressure)
    return best

from itertools import permutations
perm = permutations(unopened_valves)
best_pressure = 0
count = 0
searchspace = math.factorial(len(unopened_valves))
for i in list(perm):
    print(round(count/searchspace,4))
    count = count + 1
    best_pressure = max(create_path(best_pressure, i), best_pressure)

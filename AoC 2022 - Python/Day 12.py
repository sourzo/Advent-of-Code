# -*- coding: utf-8 -*-
"""
Created on Tue Dec 13 18:18:59 2022

@author: Zoe
"""
import numpy as np
import string

az=list(string.ascii_lowercase)

#Set input data to be an array of letters
map_list = list()
with open("Day 12.txt","r") as indata:
    for line in indata:
        line = line.strip()
        map_list.append([*line])

map_array = np.array(map_list)
del map_list, line, indata

#Set up a numeric array of the same size to mark map points as visited
map_overlay = np.zeros((map_array.shape[0], map_array.shape[1]))

def isnext(current_letter, next_letter):
    if next_letter == "S":
        return False
    else:
        if next_letter == "E":
            next_letter = "z"
        if current_letter == "S":
            current_letter = "a"
        elif current_letter == "E":
            return False
        if az.index(next_letter) - az.index(current_letter) < 2:
            return True
        else:
            return False
    
#Breadth-first search algorithm for an unweighted, undirected graph

#New coordinates are added to the search queue and marked as visited on overlay
def add_coordinate(new_row, new_col, new_distance):
    global is_finished, final_distance
    #mark it on the map overlay as visited
    map_overlay[new_row, new_col] = new_distance
    #add it to the search queue
    search_queue.append((new_row, new_col, new_distance)) 
    #Check if it is the end node
    if map_array[new_row, new_col] == "E":
        is_finished = True
        final_distance = new_distance

def get_next(map_row, map_col, distance):
    #West
    if map_col < map_array.shape[1] - 1:
        if map_overlay[map_row, map_col + 1] == 0 and isnext(map_array[map_row, map_col], map_array[map_row, map_col + 1]):
            add_coordinate(map_row, map_col + 1, distance + 1)
    #East
    if map_col > 0:
        if map_overlay[map_row, map_col - 1] == 0 and isnext(map_array[map_row, map_col], map_array[map_row, map_col - 1]):
            add_coordinate(map_row, map_col - 1, distance + 1)
    #South
    if map_row < map_array.shape[0] - 1:
        if map_overlay[map_row + 1, map_col] == 0 and isnext(map_array[map_row, map_col], map_array[map_row + 1, map_col]):
            add_coordinate(map_row + 1, map_col, distance + 1)
    #North
    if map_row > 0:
        if map_overlay[map_row - 1, map_col] == 0 and isnext(map_array[map_row, map_col], map_array[map_row - 1, map_col]):
            add_coordinate(map_row - 1, map_col, distance + 1)

search_queue = [(np.where(map_array=="S")[0][0], #row
                 np.where(map_array=="S")[1][0], #col
                 0)]                             #distance

is_finished = False

while is_finished == False and len(search_queue) > 0:
    get_next(search_queue[0][0], search_queue[0][1], search_queue[0][2])
    search_queue.pop(0)
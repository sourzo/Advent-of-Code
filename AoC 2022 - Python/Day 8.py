# -*- coding: utf-8 -*-
"""
Created on Thu Dec  8 09:18:46 2022

@author: Zoe
"""
import numpy as np

#Create forest object as a 2D array
forest_list=list()
with open("Day 8.txt") as indata:
    for line in indata:
        line = line.strip()
        line_list = list()
        for char in line:
            line_list.append(int(char))
        forest_list.append(line_list)

del line, indata, line_list, char

forest = np.array(forest_list)

del forest_list

#Look in compass directions and return height of tallest tree
def look_west(tree_row, tree_col):
    if tree_col != 0:
        return max(set(forest[tree_row,:tree_col]))
    else:
        return -1


def look_east(tree_row, tree_col):
    if tree_col != forest.shape[1]-1:
        return max(set(forest[tree_row,tree_col+1:]))
    else:
        return -1


def look_north(tree_row, tree_col):
    if tree_row != 0:
        return max(set(forest[:tree_row,tree_col]))
    else:
        return -1


def look_south(tree_row, tree_col):
    if tree_row != forest.shape[0]-1:
        return max(set(forest[tree_row+1:,tree_col]))
    else:
        return -1

#If any neighbour is smaller than current tree, it is not a candidate
def check_neighbours(tree_row, tree_col):
    neighbours = min(look_south(tree_row, tree_col),
                     look_north(tree_row, tree_col),
                     look_east(tree_row, tree_col),
                     look_west(tree_row, tree_col))
    if neighbours < forest[tree_row, tree_col]:
        return False
    else:
        return True

#Part 1: How many trees visible from outside the forest?

count_trees=0
for f_row in range(forest.shape[0]):
    for f_col in range(forest.shape[1]):
        if check_neighbours(f_row,f_col) == False:
            count_trees = count_trees + 1
            print(f_row, f_col)
            
#Part 2: Counting visible trees from current tree ------------------------
def count_west(tree_row, tree_col):
    current_tree = forest[tree_row, tree_col]
    count = 0
    tree_pos = tree_col
    tree_height = 0
    while all([tree_pos > 0,  tree_height < current_tree]):
        tree_pos = tree_pos - 1
        count = count + 1
        tree_height = forest[tree_row, tree_pos]
    return count

def count_east(tree_row, tree_col):
    current_tree = forest[tree_row, tree_col]
    count = 0
    tree_pos = tree_col
    tree_height = 0
    while all([tree_pos < forest.shape[1]-1,  tree_height < current_tree]):
        tree_pos = tree_pos + 1
        count = count + 1
        tree_height = forest[tree_row, tree_pos]
    return count

def count_north(tree_row, tree_col):
    current_tree = forest[tree_row, tree_col]
    count = 0
    tree_pos = tree_row
    tree_height = 0
    while all([tree_pos > 0,  tree_height < current_tree]):
        tree_pos = tree_pos - 1
        count = count + 1
        tree_height = forest[tree_pos, tree_col]
    return count

def count_south(tree_row, tree_col):
    current_tree = forest[tree_row, tree_col]
    count = 0
    tree_pos = tree_row
    tree_height = 0
    while all([tree_pos < forest.shape[1]-1,  tree_height < current_tree]):
        tree_pos = tree_pos + 1
        count = count + 1
        tree_height = forest[tree_pos, tree_col]
    return count

import math
scenic_score = 0

for f_row in range(forest.shape[0]):
    for f_col in range(forest.shape[1]):
       score = math.prod([count_west(f_row, f_col),
                          count_east(f_row, f_col),
                          count_north(f_row, f_col),
                          count_south(f_row, f_col)])
       scenic_score = max(scenic_score, score)
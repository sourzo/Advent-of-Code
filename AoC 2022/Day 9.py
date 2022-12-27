# -*- coding: utf-8 -*-
"""
Created on Sat Dec 10 13:10:51 2022

@author: Zoe
"""

def movehead(head, direction):
    if direction == "U":
        head[0] = head[0] + 1
    elif direction == "D":
        head[0] = head[0] - 1
    elif direction == "R":
        head[1] = head[1] + 1
    elif direction == "L":
        head[1] = head[1] - 1
    return head
        
def movetail(leader,follower):
    #vertical movement
    if leader[1] == follower[1]: #same column
        if leader[0] - follower[0] > 1:
            follower[0] = follower[0] + 1
        elif follower[0] - leader[0] > 1:
            follower[0] = follower[0] - 1
    #horizontal movement
    elif leader[0] == follower[0]: #same row
        if leader[1] - follower[1] > 1:
            follower[1] = follower[1] + 1
        elif follower[1] - leader[1] > 1:
            follower[1] = follower[1] - 1
    #diagonal movement
    elif any([abs(leader[0] - follower[0]) > 1,
              abs(leader[1] - follower[1]) > 1]):
        #vertical movement
        if leader[0] > follower[0]:
            follower[0] = follower[0] + 1
        elif leader[0] < follower[0]:
            follower[0] = follower[0] - 1
        #horizontal movement
        if leader[1] > follower[1]:
            follower[1] = follower[1] + 1
        elif leader[1] < follower[1]:
            follower[1] = follower[1] - 1
    return follower

#Part 1------------------------------------------------------------------------
#Initial positions for head and tail
h_pos = [0,0]
t_pos = [0,0]
visited=set()
with open("Day 9.txt") as indata:
          for instruction in indata:
              for repeat in range(int(instruction[2:].strip())):
                  h_pos = movehead(h_pos,instruction[0])
                  t_pos = movetail(h_pos,t_pos)
                  visited.add(tuple(t_pos))
del indata, instruction, repeat

#Part 2------------------------------------------------------------------------
rope=[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
visited_2=set()
with open("Day 9.txt") as indata:
          for instruction in indata:
              for repeat in range(int(instruction[2:].strip())):
                  movehead(rope[0],instruction[0])
                  for knot in range(9):
                      movetail(rope[knot],rope[knot+1])
                  visited_2.add(tuple(rope[9]))
                  print(rope)
del indata, instruction, repeat, knot
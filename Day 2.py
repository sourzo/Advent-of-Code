# -*- coding: utf-8 -*-
"""
Created on Sat Dec  3 14:20:08 2022

@author: Zoe
"""
#Part One

indata = open("Day 2.txt","r")
#Rock: A, X 
#Paper: B, Y 
#Scissors: C, Z

#Winning combinations: A Y, B Z, C X
#Draws: A X, B Y, C Z
score = 0
for item in indata:
    if item.strip() in ("A Y", "B Z", "C X"): #win
        score = score + 6
    elif item.strip() in ("A X", "B Y", "C Z"): #draw
        score = score + 3
    if item[2] == "X":
        score = score + 1
    elif item[2] == "Y":
        score = score + 2
    else:
        score = score + 3

indata.close()
del indata, item

#Part Two
#A = Rock           X = Lose
#B = Paper          Y = Draw
#C = Scissors       Z = Win

#               lose     draw     win
# Rock          3        1        2
# Paper         1        2        3
# Scissors      2        3        1

indata = open("Day 2.txt","r")
#Rock: A, X 
#Paper: B, Y 
#Scissors: C, Z

#Winning combinations: A Y, B Z, C X
#Draws: A X, B Y, C Z
your_score = 0
your_throw = 0
opponent_throw = 0
true_score = 0
for item in indata:
    #score for opponents throw
    if item[0] == "A":
        opponent_throw = 0
    elif item[0] == "B":
        opponent_throw = 1
    elif item[0] == "C":
        opponent_throw = 2
    #Your throw: add 2 for a loss, add 1 for a win. Then add
    if item[2] == "X":
        your_throw = (opponent_throw + 2) % 3 + 1
        your_score = your_throw
    elif item[2] == "Y":
        your_throw = (opponent_throw + 0) % 3 + 1
        your_score = your_throw + 3
    elif item[2] == "Z":
        your_throw = (opponent_throw + 1) % 3 + 1
        your_score = your_throw + 6
    true_score = true_score + your_score
    

indata.close()
del indata, item, opponent_throw, your_throw, your_score
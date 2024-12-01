# -*- coding: utf-8 -*-
"""
Created on Fri Jan  6 13:59:07 2023

@author: Zoe
"""

#switch down and up
#keep left and right the same

#Given a shapetype and a reference point (which will be different for diff shapes)
#return the coordinates of the parts of the shape
def shape(x,y,shapetype):
    if shapetype == 0: #horizontal line
        return {(x, y), (x, y+1), (x, y+2), (x, y+3)}
    elif shapetype == 1: #plus
        return {(x, y), (x+1, y-1), (x+1, y), (x+1, y+1), (x+2, y)}
    elif shapetype == 2: #backwards L
        return {(x, y), (x, y+1), (x, y+2), (x+1, y+2), (x+2, y+2)}
    elif shapetype == 3: #forwards L
        return {(x, y), (x+1, y), (x+2, y), (x+3, y)}
    elif shapetype == 4: #vertical line
        return {(x, y), (x, y+1), (x+1, y), (x+1, y+1)}

blocked_spaces = {(0,0), (0,1), (0,2), (0,3), (0,4), (0,5), (0,6), (0,7), (0,8), (0,9)}
def stopshape(x,y,shapetype):
    shape_coords = shape(x,y,shapetype)
    if any(shape_coords) in blocked_spaces:
        #something to undo the move that was just done
        for coord in shape_coords:
            blocked_spaces.add(coord)
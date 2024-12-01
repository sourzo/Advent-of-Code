# -*- coding: utf-8 -*-
"""
Created on Sun Jan  1 17:25:09 2023

@author: Zoe
"""

import pandas as pd

indata = pd.read_csv("Day 19.csv", header = None,sep=".")
robot_blueprints = pd.DataFrame(columns = ["ore_ore","clay_ore","obsidian_ore","obsidian_cly","geode_ore","geode_obs"])

for row in range(len(indata)):
    robot_blueprints.loc[row, "ore_ore"] = indata.loc[row, 0].split()[-2]
    robot_blueprints.loc[row, "clay_ore"] = indata.loc[row, 1].split()[4]
    robot_blueprints.loc[row, "obsidian_ore"] = indata.loc[row, 2].split()[4]
    robot_blueprints.loc[row, "obsidian_cly"] = indata.loc[row, 2].split()[7]
    robot_blueprints.loc[row, "geode_ore"] = indata.loc[row, 3].split()[4]
    robot_blueprints.loc[row, "geode_obs"] = indata.loc[row, 3].split()[7]
del indata, row

robot_blueprints_test = pd.DataFrame(columns = ["ore_ore","clay_ore","obsidian_ore","obsidian_cly","geode_ore","geode_obs"],
                                     index = ["r0","r1"])
robot_blueprints_test.iloc[0] = [4,2,3,14,2,7]
robot_blueprints_test.iloc[1] = [2,3,3,8,3,12]

# -*- coding: utf-8 -*-
"""
Created on Wed Dec  7 09:30:45 2022

@author: Zoe
"""
path = []
dir_dict = {"//":0}
listed_paths = set()
newpath="y"

#Turn a listed path into a string
def pathstr(alist):
    string_path=""
    for x in alist:
        string_path = string_path + "/" + x
    return string_path


with open("Day 7.txt") as indata:
    for command in indata:
        command = command.strip()
        print()
        print(command)
        
        #User command
        if command[0] == "$":
            
            #UC: Change directory
            if command [2:4] == "cd":
                #Up to parent folder
                if command[5:7] == "..":
                    path.pop()
                    print("Path = ", path)
                #set path to top directory
                elif command[5] == "/":
                    path=["/"]
                #Down into subfolder
                else:
                    path.append(command[5:])
                    print("Path = ", path)
                
                cd = pathstr(path)
                    
            #UC: List contents of current directory
            elif command[0:2] == "ls":
                print("List contents")
                if cd in listed_paths:
                    print("already looked at this one")
                    newpath = "n"
                else:
                    listed_paths.add(cd)
                    newpath = "y"
                
        #Listed directory
        elif command[0:3] == "dir" and newpath == "y":
            dir_path = pathstr(path) + "/" + command[4:]
            dir_dict.update({dir_path : 0})
            print("Encountered new directory: ", dir_path)
            print(path)
            
        #Listed file
        elif newpath == "y":
            newfile = command.split(sep=" ")
            current_path = pathstr(path)
            for x in range(len(path)):
                path_string = pathstr(path[:x+1])
                if path_string in dir_dict:
                    dir_dict[path_string] = dir_dict[path_string] + int(newfile[0])
                    

#Get all directories with file size < 100000, find the total file size (including duplicate files)
answer1 = 0
for size in dir_dict.values():
    if size < 100000:
        answer1 = answer1 + size
        
#Part 2
free_space = 70000000 - dir_dict["//"]
required = 30000000 - free_space
candidates = dict()
for x in dir_dict:
    if dir_dict[x] > required:
        candidates.update({x : dir_dict[x]})
answer2 = min(set(candidates.values()))

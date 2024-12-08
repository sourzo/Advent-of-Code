from itertools import combinations

with open("Day08.txt","r") as input:
    data = input.readlines()
data = [line.replace("\n","") for line in data]
height = len(data)
width = len(data[0])

#Part 1: Want to find the number of unique antinode locations
antinode_locations: set[tuple] = set()

#List each antenna with all its locations in the area
antenna_locations = dict()

for row, line in enumerate(data):
    for col, item in enumerate(line):
        if item != ".":
            if item not in antenna_locations:
                antenna_locations[item] = []
            antenna_locations[item].append((row, col))

def find_antinodes(antenna1: tuple, antenna2: tuple):
    antinode_row_dist = antenna2[0] - antenna1[0] # 2-1 = 1
    antinode1_row = antenna2[0] + antinode_row_dist
    antinode2_row = antenna1[0] - antinode_row_dist
    antinode_col_dist = antenna2[1] - antenna1[1] # 5-8 = -3
    antinode1_col = antenna2[1] + antinode_col_dist
    antinode2_col = antenna1[1] - antinode_col_dist

    if antinode1_row in range(0, height) and antinode1_col in range(0, width):
        antinode_locations.add((antinode1_row, antinode1_col))
    if antinode2_row in range(0, height) and antinode2_col in range(0, width):
        antinode_locations.add((antinode2_row, antinode2_col))

for locations in antenna_locations.values():
    for loc in combinations(locations, 2):
        find_antinodes(loc[0],loc[1])
print(len(antinode_locations))
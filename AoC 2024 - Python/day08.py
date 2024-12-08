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
    """Finds the antinodes for a pair of antennas.
    
    For each pair of antennas (of the same type), let d be the distance between them.
    Imagine a line drawn through the antennas. On either side of the pair of antennas, at
    a distance d from the nearest antenna, is an antinode. This function adds those antinodes
    to the set of all known antinodes."""
    antinode_row_dist = antenna2[0] - antenna1[0]
    antinode1_row = antenna2[0] + antinode_row_dist
    antinode2_row = antenna1[0] - antinode_row_dist
    antinode_col_dist = antenna2[1] - antenna1[1]
    antinode1_col = antenna2[1] + antinode_col_dist
    antinode2_col = antenna1[1] - antinode_col_dist

    if antinode1_row in range(0, height) and antinode1_col in range(0, width):
        antinode_locations.add((antinode1_row, antinode1_col))
    if antinode2_row in range(0, height) and antinode2_col in range(0, width):
        antinode_locations.add((antinode2_row, antinode2_col))

#Antinodes appear between pairs of antennas of the same value,
# so this considers all pairwise combinations of each antenna type
for locations in antenna_locations.values():
    for loc in combinations(locations, 2):
        find_antinodes(loc[0],loc[1])
print(len(antinode_locations))

#Part 2 --------------------------------------------------------------------------

def find_all_antinodes(antenna1: tuple, antenna2: tuple):
    """Finds *all* antinodes for a pair of antennas.
    
    For each pair of antennas (of the same type), let d be the distance between them.
    Imagine a line drawn through the antennas. On either side of the pair of antennas, at
    a distance k*d from the nearest antenna, is an antinode, for every integer k. 
    This function adds those antinodes to the set of all known antinodes, provided they
    appear within the bounds of the map."""
    antinode_row_dist = antenna2[0] - antenna1[0]
    antinode_col_dist = antenna2[1] - antenna1[1]

    #all antinodes outwards from antenna2
    row = antenna2[0]
    col = antenna2[1]
    k = 0
    while row in range(0, height) and col in range (0, width):
        antinode_locations.add((row, col))
        k += 1
        row = antenna2[0] + k*antinode_row_dist
        col = antenna2[1] + k*antinode_col_dist

    #all antinodes outwards from antenna1
    row = antenna1[0]
    col = antenna1[1]
    k = 0
    while row in range(0, height) and col in range (0, width):
        antinode_locations.add((row, col))
        k += 1
        row = antenna1[0] - k*antinode_row_dist
        col = antenna1[1] - k*antinode_col_dist

#As before: Consider all pairwise combinations for each type of antenna, and find all antinodes.
for locations in antenna_locations.values():
    for loc in combinations(locations, 2):
        find_all_antinodes(loc[0],loc[1])
print(len(antinode_locations))

with open("Day10example.txt","r") as input:
    map = [[int(n) for n in line if n !="\n"] for line in input.readlines()]

# A trailhead has height 0. A peak has height 9.
# A trail starts at 0 and goes 0,1,2,3,4,5,6,7,8,9.
# The score of a trailhead is the number of peaks reachable from the trailhead.
# The rating of a trailhead is the number of trails which start there.

# Part 1: What's the sum of scores of all trailheads?

# Part 2: What's the sum of ratings of all trailheads (i.e. total number of trails)?

lat_max = len(map) - 1
lon_max = len(map[0]) - 1

def expand_search(i,j):
    """Return a set of coordinates where the hiker can go next, 
    i.e. adjacent locations where the height is (current_height + 1)"""
    current_height = map[i][j]
    rtnval = set()
    if i > 0 and map[i-1][j] == current_height + 1:
        rtnval.add((i-1, j))
    if i < lat_max and map[i+1][j] == current_height + 1:
        rtnval.add((i+1, j))
    if j > 0 and map[i][j-1] == current_height + 1:
        rtnval.add((i, j-1))
    if j < lon_max and map[i][j+1] == current_height + 1:
        rtnval.add((i, j+1))
    return rtnval

def hike(search: dict[int,set[tuple[int,int]]], x: int, y: int):
    """Given the current coordinate (x,y) with height h: 
    this updates the dictionary with all coordinates of greater height accessible from point (x,y)"""
    current_height = map[x][y]
    if current_height == 9:
        return
    search.setdefault(current_height + 1, set())
    search[current_height + 1] = search[current_height + 1].union(expand_search(x, y))
    for loc in search[current_height + 1]:
        hike(search, loc[0], loc[1])

def is_neighbour(coord1: tuple[int,int], coord2: tuple[int,int]):
    if (coord1[1] == coord2[1] and abs(coord1[0] - coord2[0]) == 1) \
    or (coord1[0] == coord2[0] and abs(coord1[1] - coord2[1]) == 1):
        return True
    return False


def count_trails(search: dict[int,set[tuple[int,int]]]):
    height = 0
    trail_count = 0
    for from_loc in search[height]:
        count_neighbours = 0
        for to_loc in search[height + 1]:
            if is_neighbour(from_loc, to_loc):
                count_neighbours += 1
                #then do something...

#Count the number of 9s which are accessible from each zero
#Sum these up
count_peaks = 0
trail_count = 0
for i in range(lat_max+1):
    for j in range(lon_max+1):
        current_height = map[i][j]
        if current_height == 0:
            #Create a dict called 'search' with key = trail height (on all trails starting at map[i][j]==0), 
            # and value = set of coordinates of that height which are accessible from the original point (i,j)
            search: dict[int, set[tuple[int,int]]] = dict()
            hike(search, i,j)
            # search[9] is all the peaks accessible from trailhead (i,j)
            count_peaks += len(search[9])
        elif current_height == 9:
            trail_count += count_trails(search)
#Part 1
print(count_peaks)
#Part 1
print(trail_count)

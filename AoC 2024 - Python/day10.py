with open("Day10example.txt","r") as input:
    map = [[int(n) for n in line if n !="\n"] for line in input.readlines()]

lat_max = len(map) - 1
lon_max = len(map[0]) - 1

def expand_search(i,j):
    """Return a set of coordinates where the hiker can go next, 
    i.e. adjacent locations where the value is current_value + 1"""
    current_value = map[i][j]
    rtnval = set()
    if i > 0 and map[i-1][j] == current_value + 1:
        rtnval.add((i-1, j))
    if i < lat_max and map[i+1][j] == current_value + 1:
        rtnval.add((i+1, j))
    if j > 0 and map[i][j-1] == current_value + 1:
        rtnval.add((i, j-1))
    if j < lon_max and map[i][j+1] == current_value + 1:
        rtnval.add((i, j+1))
    return rtnval

def hike(search, x, y):
    """Finds all locations accessible from the location with coordinate (x,y)
    and updates the dict called 'search'"""
    current_value = map[x][y]
    if current_value == 9:
        return
    search.setdefault(current_value + 1, set())
    search[current_value + 1] = search[current_value + 1].union(expand_search(x, y))
    for loc in search[current_value + 1]:
        hike(search, loc[0], loc[1])

#Count the number of 9s which are accessible from each zero
#Sum these up
trails = 0
for i in range(lat_max+1):
    for j in range(lon_max+1):
        current_value = map[i][j]
        if current_value == 0:
            #Create a dict called 'search' with key = numeric value on map, 
            # and value = set of coordinates where the hiker can go next
            search: dict[int,set[tuple]] = dict()
            hike(search, i,j)
            trails += len(search[9])

print(trails)

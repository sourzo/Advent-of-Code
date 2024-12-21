import numpy as np

test = False

infile_str = "Day18example.txt" if test else "Day18.txt"
with open(infile_str, "r") as input:
    falling_bytes = [[int(x) for x in line.replace("\n", "").split(",")] for line in input.readlines()]
    #Flip the coordinates so that it matches the coordinate system used on the website
    falling_bytes = [[y, x] for [x,y] in falling_bytes]

height = 7 if test else 71
limit = 12 if test else 1024

map = np.full((height+2, height+2),".")
#pad the surrounding map with hashes to make things a bit easier
for x in range(height+2):
    map[0][x] = "#"
    map[height+1][x] = "#"
    map[x][0] = "#"
    map[x][height+1] = "#"

for byte_coord in falling_bytes[:limit]:
    map[byte_coord[0]+1][byte_coord[1]+1] = "#"

def get_children(map, node: tuple[int, int]):
    """Returns a dict of the places accessible from the current node in one step:
    Of the nodes immediately north, south, east and west of the current node which 
    are not obstacles. Will include the place just visited"""
    children: list[tuple[int, int]] = list()
    x, y = node[0] + 1, node[1]
    if map[x][y] == ".":
        children.append((x,y))
    x, y = node[0] - 1, node[1]
    if map[x][y] == ".":
        children.append((x,y))
    x, y = node[0], node[1] - 1
    if map[x][y] == ".":
        children.append((x,y))
    x, y = node[0], node[1] + 1
    if map[x][y] == ".":
        children.append((x,y))
    return children

def dijkstra(map):
    """Find the shortest path from the top left to the bottom right of the map.
    Returns the set of nodes with info about the parent node and shortest distance
    from the start via the parent node"""
    unvisited: list[tuple] = list()
    unvisited.append((1,1))
    visited: dict[tuple, tuple[int, tuple]] = dict() #A node, its distance from the start, and the parent vertex which gives it that distance
    visited[(1,1)] = (0, (1,1))
    while len(unvisited) > 0:
        current_vertex = unvisited[0]
        for child in get_children(map, current_vertex):
            #Add a distance of 1 for moving to adjacent square
            new_distance = visited[current_vertex][0] + 1
            #For this coordinate: if this is a new shortest path, then update
            if child not in visited or new_distance < visited[child][0]:
                visited[child] = (new_distance, current_vertex)
                if child not in unvisited:
                    unvisited.append(child)
        unvisited.pop(0)
    return visited


route = dijkstra(map)
print(route[(height, height)])
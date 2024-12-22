from enum import Enum

class Direction(Enum):
    NORTH = 1
    EAST = 2
    SOUTH = 3
    WEST = 4

test = True

map_file = "Day16example1.txt" if test else "Day16.txt"

with (open(map_file, "r")) as indata:
    map = [[s for s in line.replace("\n", "")] for line in indata.readlines()]

x_max = len(map) - 1
y_max = len(map[0]) - 1

#Starts in the bottom left corner, facing East
start: tuple[int, int] = (x_max - 1, int(1))
direction: Direction = Direction.EAST

# Walls are hashes: #
# Free space is dots: .
# The start is S
# The end is E

#Key = coordinates of a point on the map
#Value = tuple[shortest path distance to this point, direction facing at this point, previous point visited]
best: dict[tuple[int,int], tuple[int, Direction, tuple[int, int]]] = dict()
unvisited: list[tuple[int,int]] = list()
best[start] = (0, Direction.EAST, start)
unvisited.append(start)

def get_children(node: tuple[int, int], dir: Direction):
    """Returns a dict of the places accessible from the current node in one step:
    Of the nodes immediately north, south, east and west of the current node which 
    are not obstacles or the place just visited."""
    children: dict[Direction, tuple[int, int]] = dict()
    if dir != Direction.NORTH:
        x, y = node[0] + 1, node[1]
        if map[x][y] in (".", "E"):
            children[Direction.SOUTH] = (x,y)
    if dir != Direction.SOUTH:
        x, y = node[0] - 1, node[1]
        if map[x][y] in (".", "E"):
            children[Direction.NORTH] = (x,y)
    if dir != Direction.EAST:
        x, y = node[0], node[1] - 1
        if map[x][y] in (".", "E"):
            children[Direction.WEST] = (x,y)
    if dir != Direction.WEST:
        x, y = node[0], node[1] + 1
        if map[x][y] in (".", "E"):
            children[Direction.EAST] = (x,y)
    return children


while len(unvisited) > 0:
    current_vertex = unvisited[0]
    current_direction = best[current_vertex][1]
    for dir, pos in get_children(current_vertex, current_direction).items():
        #Add a distance of 1 for moving to adjacent square
        new_distance = best[current_vertex][0] + 1
        #Add a distance of 1000 for changing direction
        if dir != current_direction:
            new_distance += 1000
        #For this coordinate: if this is a new shortest path, then update
        if pos not in best or new_distance < best[pos][0]:
            best[pos] = (new_distance, dir, current_vertex)
            if pos not in unvisited:
                unvisited.append(pos)
    unvisited.pop(0)

print(best[(1, y_max - 1)][0])
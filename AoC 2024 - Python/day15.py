#Map info:
# A wall (immovable): #
# A box (movable): 0
# The robot: @
# Empty space: .

#Moves info:
# Up: ^, Down: v, Left: <, Right: >

from enum import Enum

test = False
moves_file = "Day15example1-moves.txt" if test else "Day15-moves.txt"
map_file = "Day15example1-map.txt" if test else "Day15-map.txt"
with (open(moves_file)) as indata:
    moves = indata.read().replace("\n","")
with (open(map_file)) as indata:
    map = [[s for s in line.replace("\n", "")] for line in indata.readlines()]
x_max = len(map) - 1
y_max = len(map[0]) - 1

class Direction(Enum):
    UP = 1
    RIGHT = 2
    DOWN = 3
    LEFT = 4

def position_in_front(dir: Direction, pos: tuple[int, int]):
    """Returns the coordinates in front of the current position,
    in the specified direction. Will return None if the position in
    front is off the edge of the map."""
    if dir == Direction.UP:
        return None if pos[0] == 0 else (pos[0] - 1, pos[1])
    elif dir == Direction.DOWN:
        return None if pos[0] == x_max else (pos[0] + 1, pos[1])
    elif dir == Direction.LEFT:
        return None if pos[1] == 0 else (pos[0], pos[1] - 1)
    elif dir == Direction.RIGHT:
        return None if pos[1] == y_max else (pos[0], pos[1] + 1)

def get_item_in_front(dir: Direction, pos: tuple[int, int]):
    """Returns the string value of the item in front"""
    pos_in_front = position_in_front(dir, pos)
    if pos_in_front is None:
        return "#"
    else:
        return map[pos_in_front[0]][pos_in_front[1]]

def move_forward(from_pos: tuple[int, int], to_dir: Direction):
    """If the space in front is clear, then this moves the item to 
    the position in front, and replaces the space left with a dot."""
    pos_in_front = position_in_front(to_dir, from_pos)
    mover = map[from_pos[0]][from_pos[1]]
    if pos_in_front is not None and get_item_in_front(to_dir, from_pos) == ".":
        map[pos_in_front[0]][pos_in_front[1]] = mover
        map[from_pos[0]][from_pos[1]] = "."
        return pos_in_front
    else:
        return from_pos
    
def push(from_pos: tuple[int, int], to_dir: Direction):
    """Moves the item in front forward (possibly pushing other items forward first).
    If the item in front is a wall (#) then the item won't move, and the wall won't move.
    
    Returns the position of the item doing the pushing after the move"""
    item_in_front = get_item_in_front(to_dir, from_pos)
    pos_in_front = position_in_front(to_dir, from_pos)
    if item_in_front == "#":
        #Don't move the wall, don't move self
        return from_pos
    elif item_in_front == ".":
        #Nothing to push, just move forward
        return move_forward(from_pos, to_dir)       
    elif pos_in_front is not None:
        #Push the item in front
        #If it moves forward and leaves a space, then the item will move forward.
        push(pos_in_front, to_dir)
        return move_forward(from_pos, to_dir)
    else:
        return from_pos

def get_direction(s: str):
    if s == "<":
        return Direction.LEFT
    elif s == ">":
        return Direction.RIGHT
    elif s == "^":
        return Direction.UP
    else:
        return Direction.DOWN

def find_robot(map: list[list[str]]):
    for row in range(1, x_max):
        for col in range(1, y_max):
            if map[row][col] == "@":
                return (row, col)
    return (-1, -1)

def apply_moves(map: list[list[str]], directions: str):
    current_position = find_robot(map)
    for move in directions:
        current_position = push(current_position, get_direction(move))

def gps(position: tuple[int,int]):
    return 100*position[0] + position[1]

def gps_total(map: list[list[str]]):
    total = 0
    for r in range(x_max):
        for c in range(y_max):
            if map[r][c] == "O":
                total += gps((r,c))
    return total

apply_moves(map, moves)
print(gps_total(map))

#Part 2 : everything is twice as wide ---------------------------------------------
new_map: list[list[str]] = list()
for idx, row in enumerate(map):
    for item in row:
        if item == "#":
            new_map[idx].extend(["##"])
        elif item == "O":
            new_map[idx].extend(["[]"])
        elif item == ".":
            new_map[idx].extend([".."])
        elif item == "@":
            new_map[idx].extend(["@."])

def move_wide_box(dir: Direction):

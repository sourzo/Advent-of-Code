from enum import Enum
import logging
import time

with open("Day06.txt","r") as indata:
    data_raw = indata.readlines()

data_raw = [line.replace("\n","") for line in data_raw]

class Direction(Enum):
    UP = 1
    RIGHT = 2
    DOWN = 3
    LEFT = 4

class Guard:
    
    direction : Direction
    position : tuple
    room: list[str]
    visited_locations: set[tuple] = set()
    visited_locations_count = dict()
    step_count: int = 0
    
    def __init__(self, puzzle_input: list[str]):
        """Looks at a puzzle input to find the guard and determine 
        their exact position (stored as a tuple) and direction"""
        self.room = [s for s in puzzle_input]
        self.visited_locations.clear()
        self.visited_locations_count.clear()
        for rownum, line in enumerate(puzzle_input):
            if "^" in line:
                self.direction = Direction.UP
                self.position = (rownum, line.index("^"))
                self.room[rownum] = line.replace("^",".")
                break
            if "<" in line:
                self.direction = Direction.LEFT
                self.position = (rownum, line.index("<"))
                self.room[rownum] = line.replace("<",".")
                break
            if ">" in line:
                self.direction = Direction.RIGHT
                self.position = (rownum, line.index(">"))
                self.room[rownum] = line.replace(">",".")
                break
            if "v" in line:
                self.direction = Direction.DOWN
                self.position = (rownum, line.index("v"))
                self.room[rownum] = line.replace("v",".")
                break
            
    def forward_position(self):
        """Returns a tuple (x,y) indicating which position is in front 
        of the guard, based on their current position and direction.
        Does not move the guard forward."""
        current_position = self.position
        if self.direction == Direction.UP:
            return (current_position[0] - 1, current_position[1])
        elif self.direction == Direction.RIGHT:
            return (current_position[0], current_position[1] + 1)
        elif self.direction == Direction.DOWN:
            return (current_position[0] + 1, current_position[1])
        else: #LEFT
            return (current_position[0], current_position[1] - 1)
    
    def move_forward(self):
        """Moves the guard forward, based on their current position and direction."""
        self.position = self.forward_position()
        self.step_count += 1
    
    def move_forward_faster(self, distance: int):
        """Updates the position by moving the guard forward the specified distance"""
        current_position = self.position
        if self.direction == Direction.UP:
            self.position = (current_position[0] - distance, current_position[1])
        elif self.direction == Direction.RIGHT:
            self.position = (current_position[0], current_position[1] + distance)
        elif self.direction == Direction.DOWN:
            self.position = (current_position[0] + distance, current_position[1])
        elif self.direction == Direction.LEFT:
            self.position = (current_position[0], current_position[1] - distance)
        self.step_count += distance

    
    def immediately_in_front(self):
        """Looks in front of the guard and returns the item, 
        or None if the guard is facing the edge"""
        forward_position = self.forward_position()
        if forward_position[0] in {-1, len(self.room)} or forward_position[1] in {-1, len(self.room[0])}:
            return None
        else:
            return self.room[forward_position[0]][forward_position[1]]
            
    def distance_to_next_object(self):
        """Returns the distance to the next object or wall"""
        look = ""
        
        if self.direction == Direction.UP:
            if self.position[0] == 0:
                return 0
            x = self.position[0] - 1
            while x >= 0 and self.room[x][self.position[1]]!="#":
                look += self.room[x][self.position[1]]
                x -= 1
                
        elif self.direction == Direction.DOWN:
            if self.position[0] == len(self.room) - 1:
                return 0
            x = self.position[0] + 1
            while x < len(self.room) and self.room[x][self.position[1]]!="#":
                look += self.room[x][self.position[1]]
                x += 1
                
        elif self.direction == Direction.LEFT:
            if self.position[1] == 0:
                return 0
            y = self.position[1] - 1
            while y >= 0 and self.room[self.position[0]][y]!="#":
                look += self.room[self.position[0]][y]
                y -= 1
                
        elif self.direction == Direction.RIGHT:
            if self.position[1] == len(self.room[0]) - 1:
                return 0
            y = self.position[1] + 1
            while y < len(self.room[0]) and self.room[self.position[0]][y]!="#":
                look += self.room[self.position[0]][y]
                y += 1
                
        return len(look)

    def rotate(self):
        """Rotates the guard's direction clockwise by 90 degrees"""
        current_dir_val = self.direction.value
        new_dir_val = current_dir_val+1 if current_dir_val < 4 else 1
        self.direction = Direction(new_dir_val)
       
    def move(self):
        """Moves the guard. If they are at the edge of the room, it returns False and they do not move. 
        Otherwise, it returns True after moving them.
        If there is an obstacle in front, they rotate right 90 degrees. Otherwise, they move forward one space."""
        look = self.immediately_in_front()
        if look is None:
            return False
        elif look == "#":
            self.rotate()
        elif look == ".":
            self.move_forward()
            self.visited_locations.add(self.position)
        return True
        
    def move_faster(self):
        """Moves the guard to the next object in front of them, 
        and then rotates them if they are not at the wall."""
        distance_to_next_object = self.distance_to_next_object()
        logging.info("Distance: " + str(distance_to_next_object))
        if distance_to_next_object > 0:
           self.move_forward_faster(distance_to_next_object)
           logging.info("Position = {}".format(self.position))
           self.visited_locations_count.setdefault(self.position, 0)
           self.visited_locations_count[self.position] += 1
        if self.immediately_in_front() is None:
            return False
        elif self.immediately_in_front() == "#":
            self.rotate()
            #print(self.direction.name)
        return True
        
    def trapped_in_loop(self):
        """Shows whether the guard is trapped in a loop by
         stopping at a square they've already stopped at."""
        return True if self.visited_locations_count.get(self.position, 0) > 1 else False

guard = Guard(data_raw)
limit_moves = 10000
guard.visited_locations.add(guard.position)
while limit_moves > 0 and guard.immediately_in_front() is not None:
   limit_moves -= 1
   guard.move()
    
print("Number of locations visited: " + str(len(guard.visited_locations)))
    
#Part 2: Don't need to count the number of locations visited, but
# will need to speed up processing in order to run the simulation many times.
# Aim is to count the number of places we can put an object in order to trap the guard in a loop.

def test_guard(guard):
    """Simulates the guard patrolling the pre-set room.
     Returns 1 if the guard is trapped in a loop"""
    limit_moves = 10000
    while limit_moves > 0 and guard.immediately_in_front() is not None:
        limit_moves -= 1
        guard.move_faster()
        if guard.trapped_in_loop():
            return 1
    else:
        return 0

count_loops = 0
progress = 0
# For each free space, try putting an object there and see if it traps the guard in a loop
t0 = time.time()
for row in range(len(data_raw)):
    for col in range(len(data_raw[row])):
        progress += 1
        logging.info("({},{})".format(row, col))
        if data_raw[row][col] == ".":
            data_raw[row] = data_raw[row][:col] + "#" + data_raw[row][col+1:]   # put the object there
            guard = Guard(data_raw)                                             # drop in a new guard
            count_loops += test_guard(guard)                                    # see if he gets stuck in a loop
            data_raw[row] = data_raw[row][:col] + "." + data_raw[row][col+1:]   # remove the object again

print("Number of ways to create loops: " + str(count_loops))
t1 = time.time()
print(t1-t0)
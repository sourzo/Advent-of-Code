with open("Day12.txt","r") as input:
    farm: list[list[str]] = [[n for n in line if n != "\n"] for line in input.readlines()]

x_max = len(farm) - 1
y_max = len(farm[0]) - 1

class Plot:
    """A partition of the farm for a single type of plants"""
    plant_type: str
    plants: set[tuple[int, int]]
    perimeter: int = 0
    perimeter_west: set[tuple[int, int]]
    perimeter_east: set[tuple[int, int]]
    perimeter_north: set[tuple[int, int]]
    perimeter_south: set[tuple[int, int]]
    
    def __init__(self, x: int, y: int):
        to_check: list[tuple[int, int]] = [(x,y)]
        self.plants = set()
        self.plant_type = farm[x][y]
        self.perimeter_north = set()
        self.perimeter_south = set()
        self.perimeter_east = set()
        self.perimeter_west = set()

        while len(to_check) > 0:
            #Pick first element in to_check;
            # Add it to shape;
            # Add any new neighbours to to_check if they are the same plant
            i, j = to_check.pop(0)
            self.plants.add((i,j))
            this_plant = farm[i][j]
            #Check each neighbouring plant, check if it is the same type
            if i > 0 and farm[i-1][j] == this_plant and (i-1, j) not in self.plants.union(set(to_check)):
                to_check.append((i-1, j))
            if i < x_max and farm[i+1][j] == this_plant and (i+1, j) not in self.plants.union(set(to_check)):
                to_check.append((i+1, j))
            if j > 0 and farm[i][j-1] == this_plant and (i, j-1) not in self.plants.union(set(to_check)):
                to_check.append((i, j-1))
            if j < y_max and farm[i][j+1] == this_plant and (i, j+1) not in self.plants.union(set(to_check)):
                to_check.append((i, j+1))
        #record the perimeter elemnts and count the total perimeter
        for plant in self.plants:
            self.perimeter += self.record_perimeter(plant)

    def size(self):
        """Number of plants in the plot"""
        return len(self.plants)            

    def record_perimeter(self, plant: tuple[int, int]):
        """Returns the perimeter score for a single plant - how much fence surrounds it. 
        Records the plant in the N/S/W/E perimeter lists if it is on the N/S/W/E perimeter repectively."""
        x, y = plant
        this_plant = farm[x][y]
        score = 0
        if x == 0 or (x > 0 and farm[x-1][y] != this_plant):
            score += 1
            self.perimeter_north.add((x,y))
        if x == x_max or (x < x_max and farm[x+1][y] != this_plant):
            score += 1
            self.perimeter_south.add((x,y))
        if y == 0 or (y > 0 and farm[x][y-1] != this_plant):
            score += 1
            self.perimeter_west.add((x,y))
        if y == y_max or (y < y_max and farm[x][y+1] != this_plant):
            score += 1
            self.perimeter_east.add((x,y))
        return score
    
    def count_intervals(self, set_of_sides: list[int]):
        """Counts the number of intervals in a list of integers. 
        
        In terms of this plant, this is used to count the number of
        sides appearing in a single row/column of the farm."""
        count = 1
        if len(set_of_sides) == 1:
            return 1
        elif len(set_of_sides) == 0:
            return 0
        current_value = set_of_sides[0]
        for elt in set_of_sides:
            if elt > current_value + 1:
                count += 1
            current_value = elt
        return count

    def count_sides(self):
        """Counts the number of sides of the plot (not the length of each side).
        
        Perimeter elements have already been assigned as north, south, east and/or west
        (with elements appearing in more than one set if it's a corner element).
        So (for example) for each row, look at the columns where a north fence appears.
        Then sort these fences by column, to determine which are adjacent (then they're 
        part of the same side). Do the same for the south fences, then do the same for 
        columns and east/west fences."""
        i_min = min([elt[0] for elt in self.perimeter_north])
        i_max = max([elt[0] for elt in self.perimeter_south])
        j_min = min([elt[1] for elt in self.perimeter_west])
        j_max = max([elt[1] for elt in self.perimeter_east])
        #Count horizontal sides
        count_sides = 0
        for i in range(i_min, i_max + 1):
            north_fences_in_row_i = sorted({elt[1] for elt in self.perimeter_north if elt[0]==i})
            count_sides += self.count_intervals(north_fences_in_row_i)
            south_fences_in_row_i = sorted({elt[1] for elt in self.perimeter_south if elt[0]==i})
            count_sides += self.count_intervals(south_fences_in_row_i)
        #Count vertical sides
        for j in range(j_min, j_max + 1):
            west_fences_in_col_j = sorted({elt[0] for elt in self.perimeter_west if elt[1]==j})
            count_sides += self.count_intervals(west_fences_in_col_j)
            east_fences_in_col_j = sorted({elt[0] for elt in self.perimeter_east if elt[1]==j})
            count_sides += self.count_intervals(east_fences_in_col_j)
        return count_sides

explored = set()
solution1 = 0 # sum of (perimeter size * number of plants in a plot)
solution2 = 0 # sum of (number of sides * number of plants in a plot)
for x in range(len(farm)):
    for y in range(len(farm[0])):
        if (x,y) not in explored:
            new_shape = Plot(x, y)
            for plant in new_shape.plants:
                explored.add(plant)
            solution1 += new_shape.perimeter*new_shape.size()
            solution2 += new_shape.count_sides()*new_shape.size()
print(solution1)
print(solution2)
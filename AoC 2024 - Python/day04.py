import re

#Get the data ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with open("Day04.txt") as input:
    grid : list[str] = input.readlines()
grid = [line.replace("\n","") for line in grid]
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Input is a crossword grid of letters - we're looking for the word "XMAS"
height = len(grid)
width = len(grid[0])

def count_horizontal(grid: list[str]):
    """Counts the forwards and backwards occurrences of 'XMAS' in the rows of the grid"""
    count = 0
    for line in grid:
        #print(line)
        count += len(re.findall("XMAS", line))
        count += len(re.findall("SAMX", line))
        #print(re.findall("XMAS|SAMX", line))
    print(count)
    return count

def transpose(grid: list[str]):
    """Transposes a crossword so that columns become rows"""
    new_grid : list[str] = [""]*width
    for line in grid:
        for i, letter in enumerate(line):
            new_grid[i] += letter
    return new_grid

def get_diagonals(grid: list[str]):
    """Returns all the diagonals as a list of strings"""
    diagonals = list()

    #down-right diagonals for lower triangle (incl. the diagonal)
    for row in range(height):
        diag = "".join([grid[row + i][i] for i in range(height-row)])
        diagonals.append(diag)

    #down-right diagonals for strictly upper triangle (excl. the diagonal)
    for col in range(1, width):
        diag = "".join([grid[i][col + i] for i in range(width-col)])
        diagonals.append(diag)

    #down-left diagonals for lower triangle (incl. the diagonal)
    for row in range(height):
        diag = "".join([grid[row + i][width-i-1] for i in range(height-row)])
        diagonals.append(diag)

    #down-left diagonals for strictly upper triangle (excl. the diagonal)
    for col in range(width-1):
        diag = "".join([grid[i][col - i] for i in range(col+1)])
        diagonals.append(diag)
    
    return diagonals

total = 0
print("diagonals")
total += count_horizontal(get_diagonals(grid))  # diagonals
print("horizontal")
total += count_horizontal(grid)                 # horizontal in original grid
print("vertical")
total += count_horizontal(transpose(grid))      # vertical in original grid
print("total")
print(total)
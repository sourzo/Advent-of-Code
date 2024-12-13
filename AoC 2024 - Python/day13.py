import re
import numpy as np
with open("Day13.txt","r") as input:
    indata = input.readlines()

indata = [(int(x), int(y)) for line in indata for x, y in re.findall("X[=+](\d+), Y[=+](\d+)", line)]
buttonsA = indata[::3]
buttonsB = indata[1::3]
prizeLocations = indata[2::3]

def scalar_multiply(s: int, t: tuple):
    return tuple([s*element for element in t])

# For each i, we want to find n, m so that
# n*(buttonsA[i][0], buttonsA[i][1]) + m*(buttonsB[i][0], buttonsB[i][1]) == (prizeLocations[i][0], prizeLocations[i][1])
# while minimising the value 3*n + m

#This is simultaneous equations!
def simultaneous_eq(i):
    mat = np.array([[buttonsA[i][0], buttonsB[i][0]], [buttonsA[i][1], buttonsB[i][1]]])
    ans = [prizeLocations[i][0], prizeLocations[i][1]]
    return np.linalg.solve(mat, ans)

def is_integer(n: float):
    if n.is_integer() or abs(n%1) < 0.0000001 or abs(n%1) > 0.9999999:
        return True
    return False

part1 = 0
# for i in range(10):
for i in range(len(prizeLocations)):
    solution = simultaneous_eq(i)
    #For some reason 40.0 in the example isn't an integer, even though it is an exact solution.
    #So assume that it's an exact solution if it's reeeeeally close to a whole number.
    if is_integer(solution[0]) and is_integer(solution[1]):
        part1 += int(3*round(solution[0]) + round(solution[1]))
        print(solution)
        
print(part1)

#Part 2 -----------------------------------------------------
prizeLocations = [scalar_multiply(10000000000000, x) for x in prizeLocations]


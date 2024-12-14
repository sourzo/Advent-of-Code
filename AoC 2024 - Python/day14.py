import re
import numpy as np
from numpy.typing import NDArray

def read_data(test):
    """Returns the initial positions of the robots and their velocities as two lists of numpy.arrays,
    and the number of rows/columns. Note the axes are flipped from how they're described on the website."""
    infile = "Day14example.txt" if test else "Day14.txt"
    with (open(infile)) as indata:
        input = indata.readlines()
        initial_positions = [np.array([int(x), int(y)]) for line in input for x, y in re.findall("p=(\d+),(\d+)", line)]
        velocities = [np.array([int(x), int(y)]) for line in input for x, y in re.findall("v=(-*\d+),(-*\d+)", line)]
    rows = 11 if test else 101
    cols = 7 if test else 103
    return initial_positions, velocities, rows, cols

def move_robot(pos: NDArray, vel: NDArray, test: bool, time: int):
    """Moves a robot by one step per unit of time. 
    Wraps the robot around the area as if it's a torus."""
    rows = 11 if test else 101
    cols = 7 if test else 103

    new = pos + vel*time
    rtn_x = new[0]%rows
    rtn_y = new[1]%cols
    return np.array([rtn_x, rtn_y])

def move_all(positions: list[NDArray], velocities: list[NDArray], test, time: int):
    """Moves all robots by one step per unit of time."""
    return [move_robot(x, y, test, time) for x, y in zip(positions, velocities)]

def count_quadrants(positions: list[NDArray], test: bool):
    """Counts the number of robots in each quadrant (ignoring robots in the middle)
    and multiplies these numbers together to give the answer for part 1."""
    rows = 11 if test else 101
    cols = 7 if test else 103

    q_size_x = (rows-1)//2
    q_size_y = (cols-1)//2

    q1 = [robot for robot in positions if robot[0] < q_size_x and robot[1] < q_size_y]
    q2 = [robot for robot in positions if robot[0] > q_size_x and robot[1] < q_size_y]
    q3 = [robot for robot in positions if robot[0] < q_size_x and robot[1] > q_size_y]
    q4 = [robot for robot in positions if robot[0] > q_size_x and robot[1] > q_size_y]

    return len(q1) * len(q2) * len(q3) * len(q4)

def part1(test: bool):
    p, v, rows, cols = read_data(test)
    positions_after_100 = move_all(p,v,test,100)
    print(count_quadrants(positions_after_100, test))

part1(True)
part1(False)

# Part 2: How many steps from the start until the robots arrange themselves in the shape of a Christmas Tree?
# I got this idea from browsing the reactions on r/AdventOfCode. Someone had graphed up the variances.
# https://www.reddit.com/r/adventofcode/comments/1he0asr/2024_day_14_part_2_why_have_fun_with_image/

def part2(num_iter: int, tolerance: float):
    """Finds the tree by looking at the variance of the (x,y) coordinates.
    When there is a significant change in variance, the algorithm halts and prints the number of iterations."""
    positions, v, rows, cols = read_data(False)
    variance_list = []
    for i in range(1, num_iter):
        positions = move_all(positions,v,False,1)
        variance = int(np.var(positions))
        variance_list.append(variance)
        if i%2000 == 0:
            print(i)
        if abs(1 - variance/np.mean(variance_list)) > tolerance:
            print(f"Tree found! After {i} iterations")
            break
    else:
        print("No tree found")

var = part2(10000, 0.4)

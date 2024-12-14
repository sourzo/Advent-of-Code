import re
import numpy as np
from numpy.typing import NDArray

def read_data(test):
    infile = "Day14example.txt" if test else "Day14.txt"
    with (open(infile)) as indata:
        input = indata.readlines()
        initial_positions = [np.array([int(x), int(y)]) for line in input for x, y in re.findall("p=(\d+),(\d+)", line)]
        velocities = [np.array([int(x), int(y)]) for line in input for x, y in re.findall("v=(-*\d+),(-*\d+)", line)]
    rows = 11 if test else 101
    cols = 7 if test else 103
    return initial_positions, velocities, rows, cols

def move_robot(pos: NDArray, vel: NDArray, test: bool, time: int):
    rows = 11 if test else 101
    cols = 7 if test else 103

    new = pos + vel*time
    rtn_x = new[0]%rows
    rtn_y = new[1]%cols
    return np.array([rtn_x, rtn_y])

def move_all(positions: list[NDArray], velocities: list[NDArray], test, time: int):
    return [move_robot(x, y, test, time) for x, y in zip(positions, velocities)]

def count_quadrants(positions: list[NDArray], test: bool):
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
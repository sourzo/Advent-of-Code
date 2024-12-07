from math import prod
import itertools as it
from enum import Enum
import time

with open("day07example.txt", "r") as input:
    raw_data = input.readlines()

test_data = dict()
for line in raw_data:
    test_value, operands = line.split(":")
    operands = operands.split()
    test_data[int(test_value)] = [int(op.strip()) for op in operands]

print(test_data)

def check_bounds(target: int, operands: list[int]):
    """Checks the upper and lower bounds for what can be produced using the operands.
    If the target value is smaller than the sum of all the operands, it returns False.
    If the target value is larger than the product of all the operands, it returns False."""
    return False if target < sum(operands) | target > prod(operands) else True

def check_mult_add(target: int, operands: list[int]):
    """Checks every permutation of adding and multiplying the values in the list.
    It does this by generating binary numbers, where 0 represents addition and 1
    represents multiplication. By generating all binary numbers of the length of
    the number of operators, you check all permutations."""
    if not check_bounds(target, operands):
        return False
    size = len(operands)
    for i in range(2**(size - 1)):
        operators = format(i, "0" + str(size-1) + "b")
        solution = operands[0]
        for j, operator in enumerate(operators):
            if solution > target:
                break
            elif operator == "0": # add
                solution = solution + operands[j+1]
            else: #multiply
                solution = solution * operands[j+1]
        if solution == target:
            return True
    return False

calibration_result = 0
for k, v in test_data.items():
    if check_mult_add(k,v):
        calibration_result += k
print(calibration_result)

# Part 2: An extra operator (concatenation)
class Operator(Enum):
    ADD = 0
    MUL = 1
    CONCAT = 2

    def operate(self, x: int, y: int):
        if self.value==0:
            return x+y
        elif self.value==1:
            return x*y
        else:
            return int(str(x) + str(y))

def check_bounds_3operators(target: int, operands: list[int]):
    """Checks the upper and lower bounds for what can be produced using the operands.
    If the target value is smaller than the sum of all the operands, it returns False.
    If the target value is larger than the concatenation of all the operands-as-strings,
    it returns False."""
    return False if target < sum(operands) | target > int("".join([str(n) for n in operands])) else True

def check_mult_add_concat(target: int, operands: list[int]):
    """Checks every permutation of adding and multiplying the values in the list.
    It does this by generating binary numbers, where 0 represents addition and 1
    represents multiplication. By generating all binary numbers of the length of
    the number of operators, you check all permutations."""
    if not check_bounds_3operators(target, operands):
        return False
    print(f"Target = {target}")
    size = len(operands)
    permutations = it.product(range(3), repeat=size-1)
    
    for permutation in permutations:
        solution = operands[0]
        for idx, val in enumerate(permutation):
            solution = Operator(val).operate(solution, operands[idx+1])
            if solution > target: 
                break
        if solution==target:
            return True
    return False

t0 = time.time()
calibration_result = 0
countdown = len(test_data)
for k, v in test_data.items():
    if check_mult_add_concat(k,v):
        calibration_result += k
    countdown -= 1
    print(countdown)
print(calibration_result)
t1 = time.time()
print(f"Time taken = {t1-t0} seconds")

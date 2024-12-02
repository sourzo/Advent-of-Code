from enum import Enum
"""Input data is a list of records, where each record is a sequence of integer 'levels'.
A record is valid in part 1 if it is a strictly increasing or strictly decreasing
sequence, and the difference between adjacent levels is no more than 3.

In Part 2, we find that records are also valid if removing a single level makes the record valid."""

#Get data ---------------------------------
with open("Day02.txt") as input:
    data_raw = input.readlines()

data : list[list[int]] = list()

for i, record in enumerate(data_raw):
    list_str = record.split()
    data.append([int(s) for s in list_str])
#------------------------------------------

class Slope(Enum):
    """Whether the gradient between two levels is increasing, decreasing, or has failed for some reason"""
    INC = 1
    DEC = 2
    FAIL = 3
    
def check_level(record: list[int], idx: int):
    """Check the validity of a level in the record.

    Checks whether the level at this idx is valid based on the value of the previous level.
    INC means a valid increase, DEC means a valid decrease, and FAIL means either the 
    difference is zero, or else the gradient is too steep."""
    diff = record[idx] - record[idx-1]
    if diff in range(1,4):
        return Slope.INC
    elif diff in range(-3, 0):
        return Slope.DEC
    else:
        return Slope.FAIL

def record_is_valid(record : list[int]):
    """Returns True if the record is valid: 
    It is strictly decreasing or strictly increasing, 
    with the difference between consecutive levels being no more than 3"""
    result : list[Slope] = list()
    for i in range(1, len(record)):
        result.append(check_level(record, i))

    if Slope.FAIL in result:
        return False
    elif Slope.DEC in result and Slope.INC in result:
        return False
    else:
        return True

##Get the answer for part 1:
record_checker : list[bool] = []
for record in data:
    if record_is_valid(record):
        record_checker.append(True)
    else:
        record_checker.append(False)

print(sum(record_checker))

#Part 2 ---------------------------------------------------

def copy_remove(some_list: list[int], idx: int):
    """Returns a copy of some_list, without the item at index 'idx'"""
    out = some_list[:idx] + some_list[idx+1:]
    return out

def error_correction(record : list):
    """Try to remove each level in turn and see if that fixes the record"""
    for i in range(len(record)):
        if record_is_valid(copy_remove(record, i)):
            return 1
    return 0

#Get the answer for part 2:
extra_valid_records = 0
for i, record in enumerate(data):
    if not record_checker[i]:
        extra_valid_records += error_correction(record)

print(sum(record_checker) + extra_valid_records)
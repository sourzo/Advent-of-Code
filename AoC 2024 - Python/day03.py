import re

with open("Day03.txt") as input:
    data_raw = input.read()

#PART 1: Find valid multiplication commands (see regex below). Multiply and add the results.
#First, need to extract all valid multiplication commands
#This requires the correct brackets, and it must start with 'mul'
#even though we won't use this info
#Spaces are NOT ignored, so 'mul ( 2 , 4 )' is not valid, for example

pattern = 'mul\(\d+,\d+\)'

def execute_multiplication_add(indata: str):
    extract_commands = re.findall(pattern, indata)

    #Extract the numbers (as pairs of strings)
    extract_numbers = [x[4:-1].split(",") for x in extract_commands]

    #turn the strings into integers and multiply
    multiplied = [int(x)*int(y) for x, y in extract_numbers]
    print("Number of multiplications = " + str(len(multiplied)))

    print(sum(multiplied))

execute_multiplication_add(data_raw)

#PART 2: multiplications are valid following "do()" but not valid following "don't()"

def extract_before_dont(input: str):
    """Extracts the first part of the string up to the point where it reaches the first substring "don't" """
    next_dont = input.find("don't()")
    if next_dont > 0:
        return input[ : next_dont]
    else:
        return input

def remove_before_do(input: str):
    """Removes the first part of the string up to and including the first occurrence of the substring "do()" """
    next_do = input.find("do()")
    if next_do > 0:
        return input[next_do + 4 : ]
    else:
        return ""
    
def remove_before_dont(input: str):
    """Removes the first part of the string up to and including the first occurrence of the substring "don't()" """
    next_dont = input.find("don't()")
    if next_dont > 0:
        return input[next_dont + 7 : ]
    else:
        return ""

#This code iteratively strips away the string from the left:
# a substring up to the first occurrence of "don't" is kept for later processing;
# a substring up to the first occurrence of "do" is discarded.
# In this way, we extract all the substrings which will be executed by the mult/sum function.
data = data_raw
keep = ""
count = len(data)
while len(data) > 0 and count > 0:
    keep += extract_before_dont(data)
    data = remove_before_dont(data)
    data = remove_before_do(data)
    count -= 1
    
execute_multiplication_add(keep)

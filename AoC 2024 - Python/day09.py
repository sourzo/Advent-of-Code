import time


#Input is a string of digits,
# which alternate between being a used memory block and a free memory block.
# Each block has a length n, and we'll call these n units "memory spaces".
# Each memory block is assigned a numeric ID: 0, 1, 2, ... in order of appearance.
# Aim is to fill the free spaces, left to right, using the used memory blocks, right to left.
# The input is almost 20,000 digits long, comprising nearly 95,000 memory spaces.

t0 = time.time()


def convert_inputs(infile: str):
    """    #Convert the input data into a tuple where:
    [0] =  data block start location (inclusive)
    [1] =  data block end location (exclusive)
    [2] = (Used space only) block ID
    """
    with open(infile,"r") as input:
        indata = input.read()

    used_space: list[list[int]] = list()
    free_space: list[list[int]] = list()
    loc = 0
    id = 0 
    for i, size in enumerate(indata):
        if i%2==0:
            used_space.append([loc, loc + int(size), id])
            loc += int(size)
            id += 1
        else:
            free_space.append([loc, loc + int(size)])
            loc += int(size)
    return used_space, free_space

moved_data_blocks = list()
used_spaces_not_moved, free_space = convert_inputs("Day09.txt")

while free_space[0][0] <= used_spaces_not_moved[-1][0]:
    candidate_data = used_spaces_not_moved[-1]
    space = free_space[0]

    space_size = space[1] - space[0]
    if space_size == 0:
        #No space to move data into
        free_space.pop(0)
        continue
    data_size = candidate_data[1] - candidate_data[0]
    if data_size < space_size:
        moved_data_blocks.append((space[0], space[0] + data_size, candidate_data[2]))
        used_spaces_not_moved.pop()
        free_space[0] = [space[0] + data_size, space[1]]
    elif data_size == space_size:
        moved_data_blocks.append((space[0], space[1], candidate_data[2]))
        used_spaces_not_moved.pop()
        free_space.pop(0)
    else:
        moved_data_blocks.append((space[0], space[1], candidate_data[2]))
        used_spaces_not_moved[-1] = ([candidate_data[0], candidate_data[1] - space_size, candidate_data[2]])
        free_space.pop(0)
    print(len(moved_data_blocks))

#Calculate the checksum
all_data = used_spaces_not_moved + moved_data_blocks

def checksum(data):
    checksum = 0
    for block in data:
        for x in range(block[0], block[1]):
            checksum += x*block[2]
    print(checksum)

checksum(all_data)

t1 = time.time()

print(f"Time taken: {t1-t0:1} seconds")

#Part 2: This time, can't split up blocks of data, so only move them if there's space for them.
# Need to iterate through the spaces left to right (i.e. move each block as far left as it will fit)
# Still iterating through the used blocks right to left

print("Part 2")
#Set up data as before
used_spaces, free_space = convert_inputs("Day09.txt")

def amalgamate_spaces(spaces: list[list[int]]):
    #First, sort the dataset
    spaces = sorted(spaces)
    #Then if there's an overlap (should be one max) then amalgamate the overlapping spaces
    for i in range(len(spaces)-1):
        if spaces[i][1] > spaces[i+1][0]:
            spaces[i][1] = spaces[i+1][1]
            spaces.pop(i+1)
            break
    return spaces

t0 = time.time()

for data_block in used_spaces[::-1]:
    data_size = data_block[1] - data_block[0]
    for idx, space in enumerate(free_space):
        if space[0] > data_block[0]:
            break
        space_size = space[1] - space[0]
        if space_size == data_size:
            orig_start = data_block[0]
            orig_end = data_block[1]
            #Change the index for the data block (i.e. move it!)
            data_block[0] = space[0]
            data_block[1] = space[1]
            #Remove the free space
            free_space.pop(idx)
            #Create new free space where the data block was;
            # amalgamate free spaces if this creates two adjacent free spaces
            free_space.append([orig_start, orig_end])
            free_space = amalgamate_spaces(free_space)
            break
        elif space_size > data_size:
            orig_start = data_block[0]
            orig_end = data_block[1]
            #Change the index for the data block (i.e. move it!)
            data_block[0] = space[0]
            data_block[1] = space[0] + data_size
            #Change the index for the free space (it's shorter now)
            free_space[idx] = [space[0] + data_size, space[1]]
            #Create new free space where the data block was;
            # amalgamate free spaces if this creates two adjacent free spaces
            free_space.append([orig_start, orig_end])
            free_space = amalgamate_spaces(free_space)
            break
    
checksum(used_spaces)

t1 = time.time()

print(f"Time taken: {t1-t0:1} seconds")

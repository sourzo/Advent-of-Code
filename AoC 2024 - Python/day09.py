import time

with open("Day09.txt","r") as input:
    indata = input.read()

print(f"Number of blocks: {len(indata)}")
print(f"Number of memory spaces: {sum([int(x) for x in indata])}")

#Input is a string of digits,
# which alternate between being a used memory block and a free memory block.
# Each block has a length n, and we'll call these n units "memory spaces".
# Each memory block is assigned a numeric ID: 0, 1, 2, ... in order of appearance.
# Aim is to fill the free spaces, left to right, using the used memory blocks, right to left.
# The input is almost 20,000 digits long, comprising nearly 95,000 memory spaces.

t0 = time.time()

#Convert the input data into a tuple where:
# [0] =  data block start location (inclusive)
# [1] =  data block end location (exclusive)
# [2] = block ID (not used for free space, which has no ID)


used_spaces_not_moved : list[tuple] = list()
free_space : list[tuple] = list()
loc = 0
id = 0 
for i, x in enumerate(indata):
    if i%2==0:
        used_spaces_not_moved.append((loc, loc + int(x), id))
        loc += int(x)
        id += 1
    else:
        free_space.append((loc, loc + int(x)))
        loc += int(x)

#Split the data into used spaces and free space
moved_data_blocks = list()

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
        free_space[0] = (space[0] + data_size, space[1])
    elif data_size == space_size:
        moved_data_blocks.append((space[0], space[1], candidate_data[2]))
        used_spaces_not_moved.pop()
        free_space.pop(0)
    else:
        moved_data_blocks.append((space[0], space[1], candidate_data[2]))
        used_spaces_not_moved[-1] = ((candidate_data[0], candidate_data[1] - space_size, candidate_data[2]))
        free_space.pop(0)
    print(len(moved_data_blocks))

#Calculate the checksum
all_data = used_spaces_not_moved + moved_data_blocks

checksum = 0
for block in all_data:
    for x in range(block[0], block[1]):
        checksum += x*block[2]

print(checksum)


t1 = time.time()

print(f"Time taken: {t1-t0:1} seconds")

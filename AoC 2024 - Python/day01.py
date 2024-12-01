from collections import Counter

#Read the data in as data of text
with open("Day01.txt") as input:
    data_raw = input.readlines()

#Split the data into left and right columns of data
list = [s.split() for s in data_raw]
left_list = [int(pair[0]) for pair in list]
right_list = [int(pair[1]) for pair in list]

#Sort each column
left_list.sort()
right_list.sort()

#Find the difference between the values pairwise, now that the data is sorted
differences = [abs(x-y) for x,y in zip(left_list, right_list)]

#And the total difference is the sum of these values
solution1 = sum(differences)
print(solution1)

#PART TWO -------------------------------------------------------------------

#Aim: Multiply each number in the left list by the number of times
frequencies = Counter(right_list)

multiplied = [x*frequencies[x] for x in left_list if x in frequencies]

#Solution is the sum of the above
solution2 = sum(multiplied)

print(solution2)
    

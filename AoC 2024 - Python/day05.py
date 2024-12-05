#Get the data ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Placement rules: Pairs (a,b) where a must not appear after b in any update
with open("Day05-rules.txt") as input:
    indata : list[str] = input.readlines()

rules : set[tuple] = set()
for line in indata:
    rules.add((int(line[:2]), int(line[3:])))

#The updates: Lists of page numbers, which must be in order according to the placement rules
with open("Day05-updates.txt") as input:
    indata : list[str] = input.readlines()

updates: list[list[int]] = list()
for line in indata:
    line_split : list[str] = line.replace("\n","").split(",")
    updates.append([int(n) for n in line_split])
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def not_before(n):
    """Returns all numbers which should not appear before number n"""
    return [y for (x, y) in rules if x == n]
def not_after(n):
    """Returns all numbers which should not appear after number n"""
    return [x for (x, y) in rules if y == n]

def n_placement_is_valid(n: int, update: list[int]):
    before_n = update[:update.index(n)]
    after_n = update[update.index(n)+1:]
    if len(set(not_before(n)) & set(before_n)) != 0 or len(set(not_after(n)) & set(after_n)) != 0:
        return False
    else:
        return True

def middle_page(update):
    return update[int(len(update)/2)]

valid_middle_pages : list[int] = list()
for update in updates:
    for n in update:
        if not n_placement_is_valid(n,update):
            break
    else:
        valid_middle_pages.append(middle_page(update))

print(sum(valid_middle_pages))

#Part 2: Put the incorrect updates in the correct order according to the placement rules!

invalid_updates : list[list[int]] = list()
for update in updates:
    for n in update:
        if not n_placement_is_valid(n, update):
            invalid_updates.append(update)
            break

#Let's go with ~~insertion sort~~
def is_gt(x,y):
    """Returns True if x is greater than y
    
    An element A is greater than B if (B,A) appears in the rules.
    """
    return True if (y,x) in rules else False

def sort(some_list: list[int]):
    """Insertion sort"""
    new_list: list[int] = list()
    count = len(some_list)+5
    while len(some_list) > 0 and count > 0:
        for i, sorted_num in enumerate(new_list):
            if is_gt(sorted_num, some_list[0]):
                new_list.insert(i, some_list[0])
                break
        else:
            new_list.append(some_list[0])
        some_list = some_list[1:]
        count -= 1
    return middle_page(new_list)

solution2 = list()
for update in invalid_updates:
    solution2.append(sort(update))
print(sum(solution2))

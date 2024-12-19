with open("day19.txt", "r") as input:
    towels = [s.strip() for s in input.readline().split(",")]    
    patterns = [s.strip() for s in input.readlines()]
print(towels)
print(patterns)

def find_prefix(pattern: str):
    possible_towels = []
    for towel in towels:
        if pattern.startswith(towel):
            possible_towels.append(towel)
    return possible_towels

count_doable_patterns = 0

def find_combination(pattern: str):
    candidate_towels = find_prefix(pattern)
    if candidate_towels == []:
        return False
    else:
        for towel in candidate_towels:
            rest_of_pattern = pattern.removeprefix(towel)
            if len(rest_of_pattern) == 0:
                return True
            else:
                if find_combination(rest_of_pattern):
                    return True
                
for pattern in patterns:
    if find_combination(pattern):
        count_doable_patterns += 1

print(count_doable_patterns)
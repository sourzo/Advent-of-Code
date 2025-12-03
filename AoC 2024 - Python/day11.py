# Rules for the stones (First applicable rule in this list):
# 1) A zero becomes a 1
# 2) An even number of digits is split in two
# 3) Else it's multiplied by 2024

def evolve_stone(n: int):
    """'Evolve' a single stone according to its displayed number"""
    if n == 0:
        return [1]
    elif len(str(n)) % 2 == 0:
        return [int(str(n)[:len(str(n))//2]), int(str(n)[len(str(n))//2:])] #note: // is integer division!
    else:
        return [n*2024]

def evolve_line(line: list[int]):
    newlist = [evolve_stone(n) for n in line]
    return sum(newlist,[])

input = [0, 89741, 316108, 7641, 756, 9, 7832357, 91]
for i in range(25):
    input = evolve_line (input)

print(len(input))

# Part 2 ---------------------------------------------------------
#This doesn't produce an answer but it's sort of getting towards one.
#My idea is that if single-digits produce a list of known single-digits 
# after a certain number of steps, then you can recursively work out how 
# long the list is. Like if f(n, i) gives the length of a list produced by 
# iterating [n] i times, then f(1, 3) = f(2, 0) + f(0, 0) + f(2, 0) + f(4, 0).
# So f(1,4) = 2*f(2, 1) + f(0, 1) + f(4, 1).
# This works well for all the single-digits except [8].

lookup: dict[int,list[int]] = dict()

def count_length(n):
    count_interations = [1]
    list_stone = [n]
    for i in range(75):
        print(f"{n} : {i}")
        list_stone = evolve_line(list_stone)
        count_interations.append(len(list_stone))
    return count_interations

# for n in range(10):
#     lookup[n] = count_length(n)

for x in range(10):
    input = [x]
    for i in range(10):
        input = evolve_line (input)
        print(f"{x}, {i+1} : {input}")
        if all(item < 10 for item in input):
            print(f"For x = {x}, iteration {i+1} gives {input}")
            break

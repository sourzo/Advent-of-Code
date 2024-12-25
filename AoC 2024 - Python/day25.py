import itertools as it

test = False

#Note - itertools.batched requires Python 3.12 or higher

infile = "Day25example.txt" if test else "Day25.txt"

with open(infile, "r") as input:
    indata = [line.strip() for line in input.readlines() if line != "\n"]

#First - split into separate objects (keys/locks)
indata = list(it.batched(indata, 7))

#Split into keys and locks
locks_picture = [item for item in indata if item[0]=="#####"]
keys_picture = [item for item in indata if item[-1]=="#####"]

def convert_to_numeric(item: tuple[str, ...]):
    item_numeric: list[int] = list()
    for i in range(5):
        item_numeric.append(len([x[i] for x in item if x[i]=="#"]) - 1)
    return tuple(item_numeric)

locks_numeric = [convert_to_numeric(lock) for lock in locks_picture]
keys_numeric = [convert_to_numeric(key) for key in keys_picture]

count_compatible = 0
for x, y in it.product(locks_numeric, keys_numeric):
    for i in range(5):
        if x[i] + y[i] > 5:
            break
    else:
        count_compatible += 1

print(f"Number of compatible key-lock combinations: {count_compatible}")

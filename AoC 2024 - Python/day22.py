with open("Day22.txt","r") as input:
    indata = [int(n) for n in input.readlines()]

def mix(n: int, m: int):
    return n^m

def prune(n: int):
    return n%16777216

def evolve(n: int):
    secret = prune(mix(n*64, n))
    secret = prune(mix(int(secret/32), secret))
    return prune(mix(secret*2048, secret))

def generate_secret_numbers(secret: int, iterations: int):
    for x in range(iterations):
        secret = evolve(secret)
    return secret

secret_sum = 0
for n in indata:
    secret_sum += generate_secret_numbers(n, 2000)

print(secret_sum)
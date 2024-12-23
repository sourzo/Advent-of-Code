import re
import networkx as nx
import itertools as it

def get_input(infile: str):
    with open(infile, "r") as input:
        indata = [{x, y} for line in input.readlines() for x, y in re.findall(r"(\w+)-(\w+)", line)]
    return indata

# Create a graph
G = nx.Graph()
G.add_edges_from(get_input("Day23.txt"))
all_cliques = list(nx.find_cliques(G))

# Find all unique 3-cliques
three_cliques = set()
for clique in all_cliques:
    if len(clique) > 2:
        #Store as a sorted tuple so it's easy to check uniqueness
        sub_3_cliques = list(sorted(x) for x in it.combinations(clique, r=3))
        #Add it if it contains an ID which starts with a 't'
        for c in sub_3_cliques:
            for node in c:
                if node.startswith("t"):
                    #Store as a tuple as it's immutable so it can be stored in a set - to check uniqueness
                    three_cliques.add(tuple(x for x in c))
                    break
print(len(three_cliques))

#Part 2 ------------
G = nx.Graph()
G.add_edges_from(get_input("Day23example.txt"))
length = (max(len(x) for x in all_cliques))
for x in all_cliques:
    if len(x) == length:
        print(",".join(sorted(x)))

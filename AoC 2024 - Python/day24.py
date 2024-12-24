def import_data(test):
    wires_file = "Day24example-wires.txt" if test else "Day24-wires.txt"
    gates_file = "Day24example-gates.txt" if test else "Day24-gates.txt"
    with open(wires_file, "r") as wires_input:
        wires_list = [x.strip().split(": ") for x in wires_input.readlines()]
        wires = {x: int(y) for x, y in wires_list}
    with open(gates_file, "r") as gates_input:
        gates = [s.strip().split(" -> ") for s in gates_input.readlines()]
    return wires, gates

wires, gates = import_data(False)
z_wires = sorted({gate[1] for gate in gates if gate[1].startswith("z")})

def operate(gate: list[str]):
    """Performs the bitwise operation on the input wires to change the value
     for the output wire. Returns True if this is successful, or False if 
     one of the input wires has no value."""
    wire1, operation, wire2 = gate[0].split(" ")
    out_wire = gate[1]
    if wire1 in wires and wire2 in wires:
        value1 = wires[wire1]
        value2 = wires[wire2]
    else:
        return False
    if operation == "OR":
        wires.setdefault(out_wire, value1|value2)
    elif operation == "XOR":
        wires.setdefault(out_wire, value1^value2)
    elif operation == "AND":
        wires.setdefault(out_wire, value1&value2)
    else:
        return False
    return True

def z_wires_all_assigned():
    for z in z_wires:
        if z not in wires:
            return False
    return True

def print_z_values():
    bin = ""
    for z in z_wires:
        bin += str(wires[z])
    print(int(bin[::-1],2))

infinite_loop_prevention_mechanism = 10000
while not z_wires_all_assigned() and infinite_loop_prevention_mechanism > 0:
    infinite_loop_prevention_mechanism -= 1
    print(infinite_loop_prevention_mechanism)
    for gate in gates:
        operate(gate)
print_z_values()
# for key in sorted(wires):
#     print(f"{key}: {wires[key]}")
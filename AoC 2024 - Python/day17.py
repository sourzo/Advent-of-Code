
test = False
debug = False

#Inputs: -----------
registerA = 729 if test else 30118712
registerB = 0
registerC = 0
instruction_pointer = 0
outputs = []

program = [0,1,5,4,3,0] if test else [2,4,1,3,7,5,4,2,0,3,1,5,5,5,3,0]
#\setup -----------

#Operators: -----------
def operator(pointer_value):
    global registerA, registerB, registerC, instruction_pointer, outputs
    opcode = program[pointer_value]
    operand = program[pointer_value + 1]
    if opcode==0:
        #adv instruction
        if debug:
            print("adv")
        registerA = int(registerA/(2**combo(operand)))
    elif opcode==1:
        #bxl instruction
        if debug:
            print("bxl")
        registerB = registerB^operand
    elif opcode==2:
        #bst instruction
        if debug:
            print("bst")
        registerB = combo(operand)%8
    elif opcode==3:
        #jnz instruction
        if debug:
            print("jnz")
        if registerA != 0:
            instruction_pointer = operand
    elif opcode==4:
        #bxc instruction
        if debug:
            print("bxc")
        registerB = registerB^registerC
    elif opcode==5:
        #out instruction
        if debug:
            print(f"out: {combo(operand)%8}")
        outputs.append(combo(operand)%8)
    elif opcode==6:
        #bdv instruction
        if debug:
            print("bdv")
        registerB = int(registerA/(2**combo(operand)))
    elif opcode==7:
        #cdv instruction
        if debug:
            print("cdv")
        registerC = int(registerA/(2**combo(operand)))
    else:
        #not valid
        print("Error! Invalid code!")
        return
    if opcode != 3 or registerA == 0:
        instruction_pointer += 2

def combo(operand: int):
    if operand < 4:
        return operand
    elif operand == 4:
        return registerA
    elif operand == 5: 
        return registerB
    elif operand == 6:
        return registerC
    else:
        Exception(f"Invalid operand: {operand}")
    
#Part 1:
print([registerA, registerB, registerC])
while instruction_pointer < len(program):
    print(f"Pointer: {instruction_pointer}, Opcode = {program[instruction_pointer]}, Operand = {program[instruction_pointer + 1]}")
    operator(instruction_pointer)
    print([registerA, registerB, registerC])

print(",".join(str(n) for n in outputs))

#Part 2:
#Brute force?
def check_outputs():
    for x, y in zip(outputs, program):
        if x != y:
            return False
    return True

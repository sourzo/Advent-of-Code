HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

BTW Open file
I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/2" AN YR "r" MKAY
I IZ STDIO'Z DIAF YR readFile MKAY
O RLY?
	YA RLY
		VISIBLE "Failed to open file for reading"
	NO WAI
		VISIBLE "Successfully opened the file for reading"
OIC
BTW Assign the whole contents of the file to a YARN
I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 99999 MKAY

OBTW
Input is a comma-separated list of ranges.
I'll create a BUKKIT called RANGES, which will contain all the ranges
Each range will be a BUKKIT with a RANGE_MIN and a RANGE_MAX
TLDR

I HAS A RANGES ITZ A BUKKIT
I HAS A position ITZ 0
RANGES HAS A length ITZ 0
I HAS A endLoop ITZ I IZ STRING'Z LEN YR contents MKAY
I HAS A numCache ITZ ""

VISIBLE "Parsing input..."
IM IN YR readLoop UPPIN YR position TIL BOTH SAEM position AN endLoop
    I HAS A char ITZ I IZ STRING'Z AT YR contents AN YR position MKAY
    char, WTF?
        OMG ","
            I HAS A varName ITZ SMOOSH RANGES'Z length AN "_max" MKAY
            RANGES HAS A SRS varName ITZ numCache
            RANGES'Z SRS varName R MAEK RANGES'Z SRS varName A NUMBR
            numCache R ""
            RANGES'Z length R SUM OF RANGES'Z length AN 1
            GTFO
        OMG "-"
            I HAS A varName ITZ SMOOSH RANGES'Z length AN "_min" MKAY
            RANGES HAS A SRS varName ITZ numCache
            RANGES'Z SRS varName R MAEK RANGES'Z SRS varName A NUMBR
            numCache R ""
            GTFO
        OMG "1"
        OMG "2"
        OMG "3"
        OMG "4"
        OMG "5"
        OMG "6"
        OMG "7"
        OMG "8"
        OMG "9"
        OMG "0"
            numCache R SMOOSH numCache AN char MKAY
            GTFO
    OIC
IM OUTTA YR readLoop
VISIBLE "... finished parsing."


VISIBLE "Computing..."
BTW Loop over all the ranges in the input

OBTW
I only need to check substrings which divide the string
TLDR

HOW IZ I divides YR numbr AN YR divisor
    BTW Check if number is divisible by divisor
    BOTH SAEM divisor AN 0, O RLY?
        YA RLY, FOUND YR FAIL
    OIC
    I HAS A quotient ITZ QUOSHUNT OF numbr AN divisor
    I HAS A multiple ITZ PRODUKT OF quotient AN divisor
    BOTH SAEM numbr AN multiple, O RLY?
        YA RLY, FOUND YR WIN
        NO WAI, FOUND YR FAIL
    OIC
IF U SAY SO

HOW IZ I SLICIN YR yarn AN YR start AN YR end
    BTW Slice a YARN
    I HAS A sliceLength ITZ DIFF OF end AN start
    I HAS A output ITZ ""
    IM IN YR sliceLoop UPPIN YR idx TIL BOTH SAEM idx AN sliceLength
        I HAS A charIdx ITZ SUM OF idx AN start
        output R SMOOSH output AN I IZ STRING'Z AT YR yarn AN YR charIdx MKAY MKAY
    IM OUTTA YR sliceLoop
    FOUND YR output
IF U SAY SO

HOW IZ I checkIfSubyarnRepeats YR yarn AN YR subyarnLength
    BTW work out if subyarns of length subyarnLength are repeated in this numbr/yarn
    I HAS A firstSubYarn ITZ I IZ SLICIN YR yarn AN YR 0 AN YR subyarnLength MKAY
    I HAS A repeatNum ITZ QUOSHUNT OF yarnLength AN subyarnLength
    IM IN YR repeatLoop UPPIN YR repeatIdx TIL BOTH SAEM repeatIdx AN repeatNum
        I HAS A subYarnStart ITZ PRODUKT OF repeatIdx AN subyarnLength
        I HAS A subYarnEnd ITZ SUM OF subYarnStart AN subyarnLength
        I HAS A subYarn ITZ I IZ SLICIN YR yarn AN YR subYarnStart AN YR subYarnEnd MKAY
        DIFFRINT firstSubYarn AN subYarn, O RLY?
            YA RLY, FOUND YR FAIL
        OIC
    IM OUTTA YR repeatLoop
    FOUND YR WIN
IF U SAY SO

HOW IZ I areThereAnyRepeatsIn YR yarn
    I HAS A yarnLength ITZ I IZ STRING'Z LEN YR yarn MKAY
    IM IN YR loop UPPIN YR subyarnLength TIL BOTH SAEM subyarnLength AN yarnLength
        I IZ divides YR yarnLength AN YR subyarnLength MKAY, O RLY?
            YA RLY, I IZ checkIfSubyarnRepeats YR yarn AN YR subyarnLength MKAY, O RLY?
                YA RLY, FOUND YR WIN
            OIC
        OIC
    IM OUTTA YR loop
    FOUND YR FAIL
IF U SAY SO

HOW IZ I exactlyTwoRepeatsIn YR yarn
    I HAS A yarnLength ITZ I IZ STRING'Z LEN YR yarn MKAY
    I HAS A subyarnLength ITZ QUOSHUNT OF yarnLength AN 2
    BOTH SAEM yarnLength AN PRODUKT OF subyarnLength AN 2, O RLY?
        YA RLY
            I HAS A subyarnLength ITZ QUOSHUNT OF yarnLength AN 2
            I IZ checkIfSubyarnRepeats YR yarn AN YR subyarnLength MKAY, O RLY?
                YA RLY, FOUND YR WIN
        OIC
    OIC
    FOUND YR FAIL
IF U SAY SO

I HAS A invalidIdSum ITZ 0

IM IN YR rangesLoop UPPIN YR rangesIdx TIL BOTH SAEM rangesIdx AN RANGES'Z length 
    I HAS A minOffset ITZ RANGES'Z SRS SMOOSH rangesIdx AN "_min" MKAY
    BTW Loop over the numbers in that range (inclusive)
    IM IN YR numberLoop UPPIN YR i TIL BOTH SAEM SUM OF i AN minOffset AN SUM OF RANGES'Z SRS SMOOSH rangesIdx AN "_max" MKAY AN 1
        I HAS A numChar ITZ SUM OF i AN minOffset
        numChar IS NOW A YARN
        I IZ exactlyTwoRepeatsIn YR numChar MKAY
        O RLY?
            YA RLY
                invalidIdSum R SUM OF SUM OF i AN minOffset AN invalidIdSum
        OIC
    IM OUTTA YR numberLoop
IM OUTTA YR rangesLoop
VISIBLE "Answer: " AN invalidIdSum
VISIBLE "... done."

KTHXBYE
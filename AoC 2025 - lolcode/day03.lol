HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

BTW Open file
I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/3" AN YR "r" MKAY
I IZ STDIO'Z DIAF YR readFile MKAY
O RLY?
	YA RLY
		VISIBLE "Failed to open file for reading"
	NO WAI
		VISIBLE "Successfully opened the file for reading"
OIC
BTW Assign the whole contents of the file to a YARN
I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 99999 MKAY
I HAS A endLoop ITZ I IZ STRING'Z LEN YR contents MKAY
VISIBLE "File size (chars): " AN endLoop

HOW IZ I isNumber YR yarn
    yarn, WTF?
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
            FOUND YR WIN
    OIC
    FOUND YR FAIL
IF U SAY SO

VISIBLE "Parsing input..."
OBTW
The input is a set of "banks" of batteries.
So each row is a bank, and each column is a battery.
The digit for the battery is its "joltage"
TLDR
I HAS A banks ITZ A BUKKIT
I HAS A bankSize ITZ 0
I HAS A batteryNumber ITZ 0
banks HAS A SRS 0 ITZ A BUKKIT

IM IN YR readLoop UPPIN YR idx TIL BOTH SAEM idx AN endLoop
    I HAS A digit ITZ I IZ STRING'Z AT YR contents AN YR idx MKAY
    I IZ isNumber YR digit MKAY, O RLY?
        YA RLY
            digit IS NOW A NUMBR
            BTW add a new battery to the bank
            banks'Z SRS bankSize HAS A SRS batteryNumber ITZ digit
            batteryNumber R SUM OF batteryNumber AN 1
        NO WAI
            BOTH SAEM digit AN ":)", O RLY?
                YA RLY
                    BTW end of line - new bank of batteries
                    bankSize R SUM OF bankSize AN 1
                    banks HAS A SRS bankSize ITZ A BUKKIT
                    batteryNumber R 0
            OIC
    OIC
IM OUTTA YR readLoop
bankSize R SUM OF bankSize AN 1

VISIBLE "... finished parsing."

VISIBLE "Computing..."

I HAS A total ITZ 0

IM IN YR bankLoop UPPIN YR bankIdx TIL BOTH SAEM bankIdx AN bankSize
    I HAS A largestFirstDigit ITZ 0
    I HAS A largestFirstDigitIdx ITZ 0
    I HAS A largestSecondDigit ITZ 0
    I HAS A bank ITZ banks'Z SRS bankIdx
    BTW for each bank of batteries, loop through the batteries - first to find the first instance of the largest joltage in the bank
    IM IN YR batteryLoop UPPIN YR batteryIdx TIL BOTH SAEM batteryIdx AN DIFF OF batteryNumber AN 1
        I HAS A joltage ITZ bank'Z SRS batteryIdx
        DIFFRINT largestFirstDigit AN BIGGR OF largestFirstDigit AN joltage
            O RLY?
                YA RLY
                BTW found the battery with the largest joltage so far
                BTW Now loop through the batteries to the right of this one to find the largest joltage for the second digit
                largestFirstDigit R joltage
                largestSecondDigit R 0
                largestFirstDigitIdx R SUM OF batteryIdx AN 1
                I HAS A endSecondDigitLoop ITZ DIFF OF batteryNumber AN largestFirstDigitIdx
                IM IN YR secondDigitLoop UPPIN YR idx TIL BOTH SAEM idx AN endSecondDigitLoop
                    I HAS A secondBatteryIdx ITZ SUM OF idx AN largestFirstDigitIdx
                    I HAS A secondJoltage ITZ bank'Z SRS secondBatteryIdx
                    largestSecondDigit R BIGGR OF largestSecondDigit AN secondJoltage
                IM OUTTA YR secondDigitLoop
            OIC
    IM OUTTA YR batteryLoop
    BTW now we have the largest 2-digit number in the bank. Add it to the total.
    I HAS A largestJoltage ITZ SMOOSH largestFirstDigit AN largestSecondDigit MKAY
    largestJoltage IS NOW A NUMBR
    total R SUM OF total AN largestJoltage
IM OUTTA YR bankLoop
VISIBLE "... finished computing."
VISIBLE "Part 1 answer: " AN total

OBTW
Part 2: Instead of selecting two batteries in each bank, select twelve.
TLDR

I HAS A total2 ITZ 0

HOW IZ I CREATE_EMPTY YR bukkitLength
    OBTW
        Creates a new BUKKIT with a given number of enumerated empty slots
        bukkitLength: the number of empty slots to create
    TLDR
    I HAS A output ITZ A BUKKIT
    output HAS A SIZE ITZ bukkitLength
    IM IN YR slotLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkitLength
        output HAS A SRS idx ITZ 0        BTW Each slot has value 0 to start
    IM OUTTA YR slotLoop
    FOUND YR output
IF U SAY SO

HOW IZ I CHOOSIN YR batteryBank
    I HAS A largestDigits ITZ I IZ CREATE_EMPTY YR 12 MKAY
    I HAS A chosenDigitIndices ITZ I IZ CREATE_EMPTY YR 12 MKAY
    chosenDigitIndices HAS A SRS -1 ITZ -1

    IM IN YR chooseLoop UPPIN YR chooseIdx TIL BOTH SAEM chooseIdx AN 12
        I HAS A remainingDigitsCount ITZ DIFF OF 12 AN chooseIdx
        I HAS A previousDigitIdx ITZ chosenDigitIndices'Z SRS DIFF OF chooseIdx AN 1
        I HAS A range ITZ DIFF OF batteryNumber AN SUM OF previousDigitIdx AN remainingDigitsCount
        BTW for each bank of batteries, loop through the batteries - first to find the first instance of the largest joltage in the bank
        IM IN YR batteryLoop UPPIN YR idx TIL BOTH SAEM idx AN range
            I HAS A batteryIdx ITZ SUM OF SUM OF previousDigitIdx AN idx AN 1
            I HAS A joltage ITZ batteryBank'Z SRS batteryIdx
            DIFFRINT largestDigits'Z SRS chooseIdx AN BIGGR OF largestDigits'Z SRS chooseIdx AN joltage, O RLY?
                YA RLY
                    largestDigits'Z SRS chooseIdx R joltage
                    chosenDigitIndices'Z SRS chooseIdx R batteryIdx
            OIC
        IM OUTTA YR batteryLoop
    IM OUTTA YR chooseLoop

    I HAS A numbr ITZ ""
    IM IN YR batteryLoop UPPIN YR idx TIL BOTH SAEM idx AN 12
        numbr R SMOOSH numbr AN largestDigits'Z SRS idx MKAY
    IM OUTTA YR batteryLoop

    numbr IS NOW A NUMBR
    total2 R SUM OF total2 AN numbr
IF U SAY SO

IM IN YR bankLoop UPPIN YR bankNum TIL BOTH SAEM bankNum AN bankSize
    I IZ CHOOSIN YR banks'Z SRS bankNum MKAY
IM OUTTA YR bankLoop
VISIBLE "... finished computing."
VISIBLE "Part 2 answer: " AN total2


VISIBLE "Finished."
KTHXBYE
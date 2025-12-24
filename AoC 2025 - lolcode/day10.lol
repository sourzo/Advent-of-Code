HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

    OBTW
        Input is complicated today. Each line represents a machine:
        - First, inside [brackets] is a light diagram
        - Next, inside (parentheses) are wiring schematics
        - Finally, inside {braces} are joltage requirements (for part 2)
        This looks like a binary numbers problem. 
        Which would be great if LOLCODE had binary numbers.

        When a button is pushed twice, it undoes the first push
        So the search space for each line is 2^n where n is the number of buttons.
    TLDR

	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/10" AN YR "r" MKAY
	I IZ STDIO'Z DIAF YR readFile MKAY
	O RLY?
		YA RLY, VISIBLE "Failed to open file for reading"
		NO WAI, VISIBLE "Successfully opened the file for reading"
	OIC

	BTW Assign the whole contents of the file to a YARN
	I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 99999 MKAY
	I IZ STDIO'Z CLOSE YR readFile MKAY

	BTW Get the number of chars in the file for later parsing
	I HAS A endLoop ITZ I IZ STRING'Z LEN YR contents MKAY 
	VISIBLE "File size (chars):: " AN endLoop

    HOW IZ I READIN YR yarn AN YR delimiter
        OBTW
            This function separates a YARN into a numerically indexed BUKKIT of YARNs using a delimiter.
        TLDR
        
        I HAS A yarnSize ITZ I IZ STRING'Z LEN YR yarn MKAY
        OBTW 
            Put a delimiter on the end of the yarn if it's not there.
            This ensures whatever's left in the buffer at the end is assigned 
        TLDR
        DIFFRINT delimiter AN I IZ STRING'Z AT YR yarn AN YR DIFF OF yarnSize AN 1 MKAY
        O RLY?
            YA RLY
                yarn R SMOOSH yarn AN delimiter MKAY
                yarnSize R SUM OF yarnSize AN 1
        OIC

        BTW Initialise bukkit, buffer
        I HAS A output ITZ A BUKKIT
        output HAS A SIZE ITZ 0
        I HAS A buffer ITZ ""

        BTW Loop through the yarn, splitting it by the delimiter
        IM IN YR readLoop UPPIN YR idx TIL BOTH SAEM idx AN yarnSize
            I HAS A char ITZ I IZ STRING'Z AT YR yarn AN YR idx MKAY
            BOTH SAEM char AN delimiter, O RLY?
                YA RLY
                    BTW Store the contents of the buffer and reset it
                    DIFFRINT buffer AN "", O RLY?
                        YA RLY, output HAS A SRS output'Z SIZE ITZ buffer
                        buffer R ""
                        output'Z SIZE R SUM OF output'Z SIZE AN 1
                    OIC
                NO WAI
                    BTW add the char to the buffer
                    buffer R SMOOSH buffer AN char MKAY
            OIC
        IM OUTTA YR readLoop
        FOUND YR output
    IF U SAY SO

    I HAS A LINEZ ITZ I IZ READIN YR contents AN YR ":)" MKAY

    OBTW
        For each line:
        First, get the light diagram.
        (1) a BUKKIT of the stated target configuration
        (2) a BUKKIT of the lights themselves, initially set to OFF (FAIL)
        Then, for each button wiring schematic, a similar looking BUKKIT but
        showing which lights are toggled by each button.
    TLDR

    HOW IZ I PRINTIN YR bukkitOfWinz
        I HAS A BUFFER ITZ ""
        IM IN YR bufferLoop UPPIN YR winIdx TIL BOTH SAEM winIdx AN bukkitOfWinz'Z SIZE
            BOTH SAEM bukkitOfWinz'Z SRS winIdx AN WIN, O RLY?
                YA RLY, BUFFER R SMOOSH BUFFER AN "#" MKAY
                NO WAI, BUFFER R SMOOSH BUFFER AN "." MKAY
            OIC
        IM OUTTA YR bufferLoop
        FOUND YR BUFFER
    IF U SAY SO

    HOW IZ I PRINTIN_BUKKITZ YR bukkitOfBukkitz
        IM IN YR slotLoop UPPIN YR slotIdx TIL BOTH SAEM slotIdx AN bukkitOfBukkitz'Z SIZE
            VISIBLE I IZ PRINTIN YR bukkitOfBukkitz'Z SRS slotIdx MKAY
        IM OUTTA YR slotLoop
    IF U SAY SO

    HOW IZ I CREATE_EMPTY YR bukkitLength
        I HAS A output ITZ A BUKKIT
        output HAS A SIZE ITZ 0
        IM IN YR slotLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkitLength
            output HAS A SRS output'Z SIZE ITZ FAIL
            output'Z SIZE R SUM OF output'Z SIZE AN 1
        IM OUTTA YR slotLoop
        FOUND YR output
    IF U SAY SO

    I HAS A BUKKIT_OF_MACHINES ITZ I IZ CREATE_EMPTY YR LINEZ'Z SIZE MKAY
    I HAS A BUKKIT_OF_DIAGRAMS ITZ I IZ CREATE_EMPTY YR LINEZ'Z SIZE MKAY
    I HAS A BUKKIT_OF_SCHEMATICS ITZ I IZ CREATE_EMPTY YR LINEZ'Z SIZE MKAY

    HOW IZ I PARSIN YR lineNum
        I HAS A LINE ITZ LINEZ'Z SRS lineNum
        
        I HAS A LIGHTS ITZ A BUKKIT             BTW The lights themselves, to be toggled on/off
        I HAS A LIGHT_DIAGRAM ITZ A BUKKIT      BTW The on/off configuration required to start the machine
        LIGHT_DIAGRAM HAS A SIZE ITZ 0
        I HAS A WIRING_SCHEMATICS ITZ A BUKKIT  BTW A list of buttons and which lights they toggle
        WIRING_SCHEMATICS HAS A SIZE ITZ 0
        I HAS A char ITZ ""
        I HAS A numberBuffer ITZ ""             BTW numbers are read in one char at a time
        I HAS A numberOfLights ITZ 0

        BTW Read the line only up to the "{"
        IM IN YR charLoop UPPIN YR charIdx TIL BOTH SAEM char AN "{"
            char R I IZ STRING'Z AT YR LINE AN YR charIdx MKAY
            char, WTF?
                OMG " "
                OMG "["
                    GTFO
                OMG "]"
                    LIGHTS R I IZ CREATE_EMPTY YR numberOfLights MKAY
                    GTFO
                OMG "("
                    BTW Create fresh wiring schematic for the new button
                    WIRING_SCHEMATICS HAS A SRS WIRING_SCHEMATICS'Z SIZE ITZ I IZ CREATE_EMPTY YR numberOfLights MKAY
                    GTFO
                OMG "#"
                    BTW "On"
                    LIGHT_DIAGRAM HAS A SRS numberOfLights ITZ WIN
                    LIGHT_DIAGRAM'Z SIZE R SUM OF LIGHT_DIAGRAM'Z SIZE AN 1
                    numberOfLights R SUM OF numberOfLights AN 1
                    GTFO
                OMG "."
                    BTW "Off"
                    LIGHT_DIAGRAM HAS A SRS numberOfLights ITZ FAIL
                    LIGHT_DIAGRAM'Z SIZE R SUM OF LIGHT_DIAGRAM'Z SIZE AN 1
                    numberOfLights R SUM OF numberOfLights AN 1
                    GTFO
                OMG ","
                    numberBuffer IS NOW A NUMBR
                    BTW This should be WIN in the wiring schematics for the current button
                    I HAS A button ITZ WIRING_SCHEMATICS'Z SRS WIRING_SCHEMATICS'Z SIZE
                    button'Z SRS numberBuffer R WIN
                    numberBuffer R ""
                    GTFO
                OMG ")"
                    numberBuffer IS NOW A NUMBR
                    BTW This should be WIN in the wiring schematics for the current button
                    I HAS A button ITZ WIRING_SCHEMATICS'Z SRS WIRING_SCHEMATICS'Z SIZE
                    button'Z SRS numberBuffer R WIN
                    numberBuffer R ""
                    WIRING_SCHEMATICS'Z SIZE R SUM OF WIRING_SCHEMATICS'Z SIZE AN 1
                    GTFO
                OMGWTF
                    BTW One digit of a number (as a YARN)
                    numberBuffer R SMOOSH numberBuffer AN char MKAY
            OIC
        IM OUTTA YR charLoop

        BTW "write out" to the external bukkit
        BUKKIT_OF_MACHINES'Z SRS lineNum R LIGHTS
        BUKKIT_OF_DIAGRAMS'Z SRS lineNum R LIGHT_DIAGRAM
        BUKKIT_OF_SCHEMATICS'Z SRS lineNum R WIRING_SCHEMATICS
    IF U SAY SO

    HOW IZ I PUSHIN YR button AN YR machine
        IM IN YR buttonLoop UPPIN YR lightNumbr TIL BOTH SAEM lightNumbr AN button'Z SIZE
            button'Z SRS lightNumbr, O RLY?
                YA RLY
                    machine'Z SRS lightNumbr R NOT machine'Z SRS lightNumbr
            OIC
        IM OUTTA YR buttonLoop
    IF U SAY SO

    HOW IZ I BOTH_SAEM YR bukkit1 AN YR bukkit2
        IM IN YR bukkitLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkit1'Z SIZE
            DIFFRINT bukkit1'Z SRS idx AN bukkit2'Z SRS idx, O RLY?
                YA RLY, FOUND YR FAIL
            OIC
        IM OUTTA YR bukkitLoop
        FOUND YR WIN
    IF U SAY SO

    HOW IZ I MATCH YR bukkit AN YR targetBukkit
        IM IN YR candidateLoop UPPIN YR candidateIdx TIL BOTH SAEM candidateIdx AN bukkit'Z SIZE
            I IZ BOTH_SAEM YR bukkit'Z SRS candidateIdx AN YR targetBukkit MKAY, O RLY?
                YA RLY, FOUND YR WIN
            OIC
        IM OUTTA YR candidateLoop
        FOUND YR FAIL
    IF U SAY SO

    HOW IZ I DEEP_COPY YR bukkit
        BTW just make a proper copy of a simple bukkit of WIN/FAIL
        I HAS A newBukkit ITZ I IZ CREATE_EMPTY YR bukkit'Z SIZE MKAY
        IM IN YR bukkitLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkit'Z SIZE
            newBukkit'Z SRS idx R bukkit'Z SRS idx
        IM OUTTA YR bukkitLoop
        FOUND YR newBukkit
    IF U SAY SO

    HOW IZ I KWIK_POWR YR exponent
        BTW Returns 2^x, assuming x > 0
        I HAS A result ITZ 1
        IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN exponent
            result R PRODUKT OF result AN 2
        IM OUTTA YR loop
        FOUND YR result
    IF U SAY SO

    HOW IZ I BINARY_PUSH YR button
        BTW Effectively adds two binary numbers together
        BOTH SAEM setOfButtonStates'Z SRS button AN FAIL, O RLY?
            YA RLY
                setOfButtonStates'Z SRS button R WIN
            NO WAI
                setOfButtonStates'Z SRS button R FAIL
                I IZ BINARY_PUSH YR SUM OF button AN 1 MKAY
        OIC
        I IZ PRINTIN YR setOfButtonStates MKAY
    IF U SAY SO

    HOW IZ I COMBINATE YR lineNum
        I HAS A lights ITZ BUKKIT_OF_MACHINES'Z SRS lineNum
        I HAS A setOfButtons ITZ BUKKIT_OF_SCHEMATICS'Z SRS lineNum
        I HAS A target ITZ BUKKIT_OF_DIAGRAMS'Z SRS lineNum

        BTW Might as well check if the lights are already the same as the target
        I IZ BOTH_SAEM YR lights AN YR target MKAY, O RLY?
            YA RLY, FOUND YR 0
        OIC
       
        I HAS A minNumberOfButtons ITZ setOfButtons'Z SIZE
        BTW  max = 2^(n-1) - 1
        I HAS A max ITZ DIFF OF I IZ KWIK_POWR YR setOfButtons'Z SIZE MKAY AN 1
        BTW so we can tell if each button is on (WIN) or off (FAIL)
        I HAS A setOfButtonStates ITZ I IZ CREATE_EMPTY YR setOfButtons'Z SIZE MKAY

        BTW push 1st button repeatedly, triggering the pushing of the other buttons
        IM IN YR binaryLoop UPPIN YR numbr TIL BOTH SAEM numbr AN max
            I HAS A freshSetOfLights ITZ I IZ DEEP_COPY YR lights MKAY
            I HAS A countButtons ITZ 0
            BTW This is the binary equivalent of adding 1 to the number represented by setOfButtonStates
            I IZ BINARY_PUSH YR 0 MKAY
            IM IN YR buttonloop UPPIN YR buttonIdx TIL BOTH SAEM buttonIdx AN setOfButtonStates'Z SIZE
                BOTH SAEM setOfButtonStates'Z SRS buttonIdx AN WIN, O RLY?
                    YA RLY
                        I IZ PUSHIN YR setOfButtons'Z SRS buttonIdx AN YR freshSetOfLights MKAY
                        countButtons R SUM OF countButtons AN 1
                OIC
            IM OUTTA YR buttonloop
            I IZ BOTH_SAEM YR freshSetOfLights AN YR target MKAY, O RLY?
                YA RLY
                    minNumberOfButtons R SMALLR OF minNumberOfButtons AN countButtons
            OIC
        IM OUTTA YR binaryLoop
        FOUND YR minNumberOfButtons
    IF U SAY SO

    I HAS A SOLUTION ITZ 0
    IM IN YR machineLoop UPPIN YR machineIdx TIL BOTH SAEM machineIdx AN LINEZ'Z SIZE
        VISIBLE machineIdx
        BTW Parse the line to create the initial state of each machine
        I IZ PARSIN YR machineIdx MKAY
        SOLUTION R SUM OF SOLUTION AN I IZ COMBINATE YR machineIdx MKAY
    IM OUTTA YR machineLoop

    VISIBLE "Solution:: " AN SOLUTION

KTHXBYE
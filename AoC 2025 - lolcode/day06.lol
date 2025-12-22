HAI 1.3
    CAN HAS STDIO?
    CAN HAS STRING?

    OBTW
        This one is going to be an arse to parse
        The delimiters for each line are any number of spaces. Yay.
        Also, it's columns of numbers to be added or multiplied
        depending on the symbol at the bottom of each column.
        It looks like there's only 3 rows.
        The goal (for part 1) is to add and multiply all the numbers
        in each column, then add together all the answers
    TLDR

    HOW IZ I charIsNumeric YR char
        char, WTF?
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
            OMGWTF
                FOUND YR FAIL
        OIC
    IF U SAY SO

    HOW IZ I isNumbr YR yarn
        BTW Checks if a YARN can be cast into a NUMBR
        IM IN YR yarnLoop UPPIN YR yarnIdx TIL BOTH SAEM yarnIdx AN I IZ STRING'Z LEN YR yarn MKAY
            I HAS A char ITZ I IZ STRING'Z AT YR yarn AN YR yarnIdx MKAY
            BOTH SAEM FAIL AN I IZ charIsNumeric YR char MKAY, O RLY?
                YA RLY, FOUND YR FAIL
            OIC
        IM OUTTA YR yarnLoop
        FOUND YR WIN
    IF U SAY SO

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
                        YA RLY
                            output HAS A SRS output'Z SIZE ITZ buffer
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
        

	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/6" AN YR "r" MKAY
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

    I HAS A LINEZ ITZ I IZ READIN YR contents AN YR ":)" MKAY

    I HAS A NUMBRZ ITZ A BUKKIT
    NUMBRZ HAS A SIZE ITZ 0
    I HAS A OPERATORZ ITZ A BUKKIT
    OPERATORZ HAS A SIZE ITZ 0

    IM IN YR lineLoop UPPIN YR lineIdx TIL BOTH SAEM lineIdx AN LINEZ'Z SIZE
        I HAS A parsedLine ITZ I IZ READIN YR LINEZ'Z SRS lineIdx AN YR " " MKAY
        I HAS A firstItem ITZ parsedLine'Z SRS 0
        I IZ isNumbr YR firstItem MKAY, O RLY?
            YA RLY
                BTW This is one of the lines of numbers. Convert to NUMBR and store
                IM IN YR colLoop UPPIN YR colIdx TIL BOTH SAEM colIdx AN parsedLine'Z SIZE
                    I HAS A numbr ITZ parsedLine'Z SRS colIdx
                    numbr IS NOW A NUMBR
                IM OUTTA YR colLoop
                NUMBRZ HAS A SRS lineIdx ITZ parsedLine
                NUMBRZ'Z SIZE R SUM OF NUMBRZ'Z SIZE AN 1
            NO WAI
                BTW The last line - the plusses and asterisks
                OPERATORZ R parsedLine
        OIC
    IM OUTTA YR lineLoop

    OBTW
        Now do the multiplications and additions
    TLDR

    HOW IZ I addColumn YR bukkit AN YR idx
        I HAS A total ITZ 0
        IM IN YR bukkitLoop UPPIN YR lineIdx TIL BOTH SAEM lineIdx AN bukkit'Z SIZE
            I HAS A line ITZ bukkit'Z SRS lineIdx
            total R SUM OF total AN line'Z SRS idx
        IM OUTTA YR bukkitLoop
        FOUND YR total
    IF U SAY SO

    HOW IZ I multiplyColumn YR bukkit AN YR idx
        I HAS A product ITZ 1
        IM IN YR bukkitLoop UPPIN YR lineIdx TIL BOTH SAEM lineIdx AN bukkit'Z SIZE
            I HAS A line ITZ bukkit'Z SRS lineIdx
            product R PRODUKT OF product AN line'Z SRS idx
        IM OUTTA YR bukkitLoop
        FOUND YR product
    IF U SAY SO

    I HAS A solution ITZ 0
    IM IN YR operatorLoop UPPIN YR opIdx TIL BOTH SAEM opIdx AN OPERATORZ'Z SIZE
        VISIBLE "Progress:: " AN opIdx
        BOTH SAEM OPERATORZ'Z SRS opIdx AN "+", O RLY?
            YA RLY, solution R SUM OF solution AN I IZ addColumn YR NUMBRZ AN YR opIdx MKAY
        MEBBE BOTH SAEM OPERATORZ'Z SRS opIdx AN "*"
            solution R SUM OF solution AN I IZ multiplyColumn YR NUMBRZ AN YR opIdx MKAY
        OIC
    IM OUTTA YR operatorLoop
    
    VISIBLE "Solution:: " AN solution

KTHXBYE
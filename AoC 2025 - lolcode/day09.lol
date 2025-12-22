HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/9" AN YR "r" MKAY
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
                    I IZ isNumbr YR buffer MKAY, O RLY?
                        YA RLY, buffer IS NOW A NUMBR
                    OIC
                    DIFFRINT buffer AN "", O RLY?
                        YA RLY, output HAS A SRS output'Z SIZE ITZ buffer
                        buffer R ""
                        output'Z SIZE R SUM OF output'Z SIZE AN 1
                    MEBBE BOTH SAEM delimiter AN ""
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

    I HAS A LINEZ ITZ I IZ READIN YR contents AN YR ":)" MKAY

    BTW Store the coordinates in a BUKKIT
    I HAS A RED_TILEZ ITZ A BUKKIT
    RED_TILEZ HAS A SIZE ITZ 0
    
    IM IN YR linezLoop UPPIN YR lineidx TIL BOTH SAEM lineidx AN LINEZ'Z SIZE
        RED_TILEZ HAS A SRS RED_TILEZ'Z SIZE ITZ I IZ READIN YR LINEZ'Z SRS lineidx AN YR "," MKAY
        RED_TILEZ'Z SIZE R SUM OF RED_TILEZ'Z SIZE AN 1
    IM OUTTA YR linezLoop

    HOW IZ I MEASURIN YR coords1_idx AN YR coords2_idx
        OBTW
            Finds the area of the rectangle which has coords1 
            at one corner and coords2 at the other corner
        TLDR

        I HAS A coords1 ITZ RED_TILEZ'Z SRS coords1_idx
        I HAS A coords2 ITZ RED_TILEZ'Z SRS coords2_idx
        
        I HAS A x_max ITZ BIGGR OF coords1'Z SRS 0 AN coords2'Z SRS 0
        I HAS A x_min ITZ SMALLR OF coords1'Z SRS 0 AN coords2'Z SRS 0
        I HAS A y_max ITZ BIGGR OF coords1'Z SRS 1 AN coords2'Z SRS 1
        I HAS A y_min ITZ SMALLR OF coords1'Z SRS 1 AN coords2'Z SRS 1

        I HAS A x_dist ITZ SUM OF 1 AN DIFF OF x_max AN x_min
        I HAS A y_dist ITZ SUM OF 1 AN DIFF OF y_max AN y_min

        FOUND YR PRODUKT OF x_dist AN y_dist
    IF U SAY SO

    I HAS A largestArea ITZ 0

    IM IN YR tile1Loop UPPIN YR tile1idx TIL BOTH SAEM tile1idx AN RED_TILEZ'Z SIZE
        IM IN YR tile2Loop UPPIN YR tile2idx TIL BOTH SAEM tile2idx AN tile1idx
            largestArea R BIGGR OF largestArea AN I IZ MEASURIN YR tile1idx AN YR tile2idx MKAY
        IM OUTTA YR tile2Loop
    IM OUTTA YR tile1Loop

    VISIBLE "Solution:: " AN largestArea


KTHXBYE
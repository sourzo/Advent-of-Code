HAI 1.3

CAN HAS STDIO?
CAN HAS STRING?

    OBTW
        Input today is heterogeneous so it needs to be separated.
        The first part is a set of ingredient ID ranges. (I'm calling these RANGEZ, oo la la)
        The second part is a set of ingredient IDs. (I'm calling these NOMZ)

        If you're getting déja vu, take a look at day 2.
    TLDR

	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/5" AN YR "r" MKAY
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
        BTW VISIBLE "readloop idx:: " AN idx
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

    HOW IZ I ADDIN YR item AN YR bukkit
        OBTW
            This adds the item to the bukkit. This assumes that the bukkit has a SIZE.
        TLDR
        bukkit HAS A SRS bukkit'Z SIZE ITZ item
        bukkit'Z SIZE R SUM OF bukkit'Z SIZE AN 1
    IF U SAY SO

    BTW Parse the input into lines of text, indexed numerically
    I HAS A LINEZ ITZ I IZ READIN YR contents AN YR ":)" MKAY

    BTW Initialise RANGEZ and NOMZ
    I HAS A RANGEZ ITZ A BUKKIT
    RANGEZ HAS A SIZE ITZ 0
    I HAS A NOMZ ITZ A BUKKIT
    NOMZ HAS A SIZE ITZ 0
    I HAS A areWeOntoTheNomzNow ITZ FAIL BTW Switch

    IM IN YR arrayLoop UPPIN YR lineNumber TIL BOTH SAEM lineNumber AN LINEZ'Z SIZE
        BTW #TODO What about the blank line?
        areWeOntoTheNomzNow, O RLY?
            YA RLY
                BTW Ingredient ID
                LINEZ'Z SRS lineNumber IS NOW A NUMBR
                I IZ ADDIN YR LINEZ'Z SRS lineNumber AN YR NOMZ MKAY
            NO WAI
                I IZ isNumbr YR LINEZ'Z SRS lineNumber MKAY, O RLY?
                    YA RLY
                        BTW Ingredient ID
                        areWeOntoTheNomzNow R WIN
                        LINEZ'Z SRS lineNumber IS NOW A NUMBR
                        I IZ ADDIN YR LINEZ'Z SRS lineNumber AN YR NOMZ MKAY
                    NO WAI
                        BTW Ingredient ID range
                        I HAS A delimitedLine ITZ I IZ READIN YR LINEZ'Z SRS lineNumber AN YR "-" MKAY
                        delimitedLine'Z SRS 0 IS NOW A NUMBR
                        delimitedLine'Z SRS 1 IS NOW A NUMBR
                        VISIBLE delimitedLine'Z SRS 0 AN "--" AN delimitedLine'Z SRS 1
                        I IZ ADDIN YR delimitedLine AN YR RANGEZ MKAY
                OIC
        OIC
    IM OUTTA YR arrayLoop

    HOW IZ I IS_IN_RANGES YR numbr
        OBTW
            Checks if the numbr is in any of the ranges
        TLDR
        VISIBLE "IS_IN_RANGES - " AN numbr
        IM IN YR rangeLoop UPPIN YR rangeID TIL BOTH SAEM rangeID AN RANGEZ'Z SIZE
            I HAS A range ITZ RANGEZ'Z SRS rangeID
            I HAS A lowerLimit ITZ range'Z SRS 0
            I HAS A upperLimit ITZ range'Z SRS 1
            VISIBLE lowerLimit AN " - " AN upperLimit
            BOTH OF BOTH SAEM lowerLimit AN SMALLR OF numbr AN lowerLimit AN BOTH SAEM upperLimit AN BIGGR OF numbr AN upperLimit, O RLY?
                YA RLY, FOUND YR WIN
            OIC
        IM OUTTA YR rangeLoop
        FOUND YR FAIL
    IF U SAY SO

    I HAS A countFreshNomz ITZ 0
    IM IN YR nomzLoop UPPIN YR nomnum TIL BOTH SAEM nomnum AN NOMZ'Z SIZE
        I IZ IS_IN_RANGES YR NOMZ'Z SRS nomnum MKAY, O RLY?
            YA RLY, countFreshNomz R SUM OF countFreshNomz AN 1
        OIC
    IM OUTTA YR nomzLoop

    VISIBLE "Solution:: " AN countFreshNomz
KTHXBYE
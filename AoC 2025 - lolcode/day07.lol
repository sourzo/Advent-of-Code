HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/7" AN YR "r" MKAY
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
            This function separates a YARN into a numerically indexed BUKKIT of 
            YARNs using a delimiter. If delimiter is "" then it will split each 
            character into a separate slot.
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
    
    I HAS A diagram ITZ I IZ READIN YR contents AN YR ":)" MKAY

    O HAI IM tachyonBeam
        I HAS A SIZE ITZ I IZ STRING'Z LEN YR diagram'Z SRS 0 MKAY
        I HAS A SPLIT_COUNT ITZ 0

        HOW IZ I SPLIT YR idx
            ME'Z SPLIT_COUNT R SUM OF ME'Z SPLIT_COUNT AN 1
            ME'Z SRS idx R FAIL
            ME'Z SRS SUM OF idx AN 1 R WIN
            ME'Z SRS DIFF OF idx AN 1 R WIN
        IF U SAY SO

        HOW IZ I IS_BEAM_HERE YR idx
            FOUND YR ME'Z SRS idx
        IF U SAY SO
    KTHX

    IM IN YR populateBeamLoop UPPIN YR idx TIL BOTH SAEM idx AN tachyonBeam'Z SIZE
        tachyonBeam HAS A SRS idx ITZ FAIL
    IM OUTTA YR populateBeamLoop


    IM IN YR lineLoop UPPIN YR lineIdx TIL BOTH SAEM lineIdx AN diagram'Z SIZE
        I HAS A line ITZ diagram'Z SRS lineIdx
        IM IN YR beamLoop UPPIN YR beamIdx TIL BOTH SAEM beamIdx AN tachyonBeam'Z SIZE
            I IZ STRING'Z AT YR line AN YR beamIdx MKAY, WTF?
                OMG "S"
                    tachyonBeam'Z SRS beamIdx R WIN
                    GTFO
                OMG "^"
                    tachyonBeam IZ IS_BEAM_HERE YR beamIdx MKAY, O RLY?
                        YA RLY, tachyonBeam IZ SPLIT YR beamIdx MKAY
                    OIC
            OIC
        IM OUTTA YR beamLoop
    IM OUTTA YR lineLoop

    VISIBLE "Solution:: " AN tachyonBeam'Z SPLIT_COUNT


KTHXBYE
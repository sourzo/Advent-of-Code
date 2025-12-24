HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/11" AN YR "r" MKAY
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

    HOW IZ I printArrayofPrimitives YR bukkit
		IM IN YR printLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkit'Z SIZE
			VISIBLE idx AN ":: " AN bukkit'Z SRS idx
		IM OUTTA YR printLoop
	IF U SAY SO

    I HAS A LINEZ ITZ I IZ READIN YR contents AN YR ":)" MKAY
    I HAS A DEVICES_DICT ITZ A BUKKIT
    I HAS A PATH_COUNT ITZ 0

    IM IN YR lineLoop UPPIN YR lineNum TIL BOTH SAEM lineNum AN LINEZ'Z SIZE
        VISIBLE lineNum AN " of " AN LINEZ'Z SIZE
        I HAS A parsedByColon ITZ I IZ READIN YR LINEZ'Z SRS lineNum AN YR "::" MKAY
        I HAS A outputsBukkit ITZ I IZ READIN YR parsedByColon'Z SRS 1 AN YR " " MKAY
        DEVICES_DICT HAS A SRS parsedByColon'Z SRS 0 ITZ outputsBukkit
    IM OUTTA YR lineLoop

    HOW IZ I countPaths YR deviceName
        BOTH SAEM deviceName AN "out", O RLY?
            YA RLY
                PATH_COUNT R SUM OF PATH_COUNT AN 1
            NO WAI
                I HAS A dictOfOutputs ITZ DEVICES_DICT'Z SRS deviceName
                IM IN YR outputLoop UPPIN YR outputNum TIL BOTH SAEM outputNum AN dictOfOutputs'Z SIZE
                    I IZ countPaths YR dictOfOutputs'Z SRS outputNum MKAY
                IM OUTTA YR outputLoop
        OIC

    IF U SAY SO

    I IZ countPaths YR "you" MKAY
    VISIBLE PATH_COUNT

KTHXBYE
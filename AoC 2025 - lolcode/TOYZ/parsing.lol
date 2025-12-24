HAI 1.3

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

KTHXBYE
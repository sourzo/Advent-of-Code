HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?



BTW Open file
I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "TREATZ/1" AN YR "r" MKAY
I IZ STDIO'Z DIAF YR readFile MKAY
O RLY?
	YA RLY
		VISIBLE "Failed to open file for reading"
	NO WAI
		VISIBLE "Successfully opened the file for reading"
OIC

BTW Create a string for reading the whole file
I HAS A linez ITZ A YARN
I HAS A instructions ITZ A BUKKIT
instructions HAS A countLines ITZ 0
instructions HAS A directions ITZ A BUKKIT
instructions HAS A distances ITZ A BUKKIT
I HAS A count ITZ 0
I HAS A size

HOW IZ I ISNUMBR YR char
    BTW returns WIN if char is an integer, else FAIL
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
IF U SAY SO

HOW IZ I PARSENUMBR YR yarn
    IM IN YR parseloop UPPIN YR count WILE 
IF U SAY SO

O HAI IM stack
    BTW First-in-first-out stack should work well for most AoC inputs
    I HAS A contents ITZ A BUKKIT
    I HAS A length ITZ 0
    
    HOW IZ I PUT YR item
        I'Z contents SRS length R item
        I'Z length R SUM OF length AN 1
    IF U SAY SO

    HOW IZ I GET YR index
        FOUND YR contents'Z SRS index
    IF U SAY SO
KTHX

O HAI IM instructions
    I HAS A directions ITZ A BUKKIT
    I HAS A distances ITZ A BUKKIT
    I HAS A length ITZ 0


KTHX

BTW Read in from file (1024 bytes)
IM IN YR readLoop UPPIN YR count WILE WIN
    I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 999999 MKAY
    size R I IZ STRING'Z LEN YR contents MKAY BTW size = STRING.LEN(contents)
    BOTH SAEM size AN 0, O RLY?
        YA RLY, GTFO
    OIC
    linez R SMOOSH linez AN contents MKAY
    contents, WTF?
        OMG "R"
        OMG "L"
            countLines R SUM OF countLines AN 1
            instructions'Z directions HAS A SRS countLines ITZ contents
            BTW TODO Line break? Is it :) or is it : then )?
        OMGWTF
            instructions'Z SRS countLines R SMOOSH instructions'Z SRS countLines AN contents MKAY
IM OUTTA YR readLoop



BTW Close file
I IZ STDIO'Z CLOSE YR readFile MKAY

I HAS A linezLength ITZ I IZ STRING'Z LEN YR linez MKAY
VISIBLE SMOOSH "linez length: " AN linezLength MKAY
VISIBLE linez

BTW Suppose input.



KTHXBYE
HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?
 
BTW Open file
I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/1" AN YR "r" MKAY
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
Loop through the YARN input character-by-character and assign to BUKKITZ
So there's a BUKKIT called INSTRUKSHUNZ and it contains two BUKKITZ: 
DIREKSHUNZ (R/L) and KLIKZ (The number of clicks to turn the dial)
TLDR

I HAS A INSTRUKSHUNZ ITZ A BUKKIT
INSTRUKSHUNZ HAS A LENGTH ITZ 0
INSTRUKSHUNZ HAS A DIREKSHUNZ ITZ A BUKKIT
INSTRUKSHUNZ HAS A KLIKZ ITZ A BUKKIT
INSTRUKSHUNZ'Z KLIKZ HAS A SRS "-1" ITZ "-1"

I HAS A position ITZ 0
I HAS A endLoop ITZ I IZ STRING'Z LEN YR contents MKAY
I HAS A index ITZ -1
I HAS A newLine ITZ WIN

VISIBLE "Parsing input..."
IM IN YR loop UPPIN YR position TIL BOTH SAEM position AN endLoop
    I HAS A char ITZ I IZ STRING'Z AT YR contents AN YR position MKAY
    char, WTF?
        OMG "R"
        OMG "L"
            INSTRUKSHUNZ'Z KLIKZ'Z SRS index IS NOW A NUMBR
            index R SUM OF index AN 1
            newLine R WIN

            INSTRUKSHUNZ'Z DIREKSHUNZ HAS A SRS index ITZ char
            INSTRUKSHUNZ'Z LENGTH R SUM OF index AN 1 
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
            BTW Either create a new var in KLIKZ or add to existing var
            newLine, WTF?
                OMG WIN, INSTRUKSHUNZ'Z KLIKZ HAS A SRS index ITZ char, GTFO
                OMG FAIL, INSTRUKSHUNZ'Z KLIKZ'Z SRS index R SMOOSH INSTRUKSHUNZ'Z KLIKZ'Z SRS index AN char MKAY, GTFO
            OIC
            newLine R FAIL
            GTFO
    OIC
IM OUTTA YR loop
INSTRUKSHUNZ'Z KLIKZ'Z SRS index IS NOW A NUMBR
VISIBLE "... done parsing."

BTW Onto the actual problem
I HAS A dialPosition ITZ 50
I HAS A idx ITZ 0
I HAS A zeroCount ITZ 0
VISIBLE "Computing..."
IM IN YR instructionsLoop UPPIN YR idx WILE DIFFRINT idx AN BIGGR OF idx AN INSTRUKSHUNZ'Z LENGTH 
    INSTRUKSHUNZ'Z DIREKSHUNZ'Z SRS idx, WTF?
        OMG "R"
            dialPosition R MOD OF SUM OF dialPosition AN INSTRUKSHUNZ'Z KLIKZ'Z SRS idx AN 100
            GTFO
        OMG "L"
            dialPosition R MOD OF DIFF OF dialPosition AN INSTRUKSHUNZ'Z KLIKZ'Z SRS idx AN 100
            DIFFRINT 0 AN SMALLR OF 0 AN dialPosition, O RLY?
                YA RLY, dialPosition R SUM OF dialPosition AN 100
            OIC
            GTFO
    OIC
    BTW VISIBLE INSTRUKSHUNZ'Z DIREKSHUNZ'Z SRS idx AN dialPosition
    BOTH SAEM dialPosition AN 0, O RLY?
        YA RLY, zeroCount R SUM OF zeroCount AN 1
    OIC
IM OUTTA YR instructionsLoop
VISIBLE "... done."
VISIBLE zeroCount

KTHXBYE
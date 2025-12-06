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
I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 99999 MKAY

I HAS A INSTRUKSHUNZ ITZ A BUKKIT
INSTRUKSHUNZ HAS A DIREKSHUNZ ITZ A BUKKIT
INSTRUKSHUNZ HAS A KLIKZ ITZ A BUKKIT
INSTRUKSHUNZ'Z KLIKZ HAS A SRS "-1" ITZ "-1"

I HAS A position ITZ 0
I HAS A endLoop ITZ I IZ STRING'Z LEN YR contents MKAY
I HAS A index ITZ -1
I HAS A newLine ITZ WIN
IM IN YR loop UPPIN YR position TIL BOTH SAEM position AN endLoop
    I HAS A char ITZ I IZ STRING'Z AT YR contents AN YR position MKAY
    char, WTF?
        OMG "R"
        OMG "L"
            INSTRUKSHUNZ'Z KLIKZ'Z SRS index IS NOW A NUMBR
            index R SUM OF index AN 1
            newLine R WIN

            INSTRUKSHUNZ'Z DIREKSHUNZ HAS A SRS index ITZ char
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





KTHXBYE
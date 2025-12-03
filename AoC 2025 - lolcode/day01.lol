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
I HAS A count ITZ 0
I HAS A size

BTW Read in from file (1024 bytes)
IM IN YR readLoop UPPIN YR count WILE WIN
    I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 999999 MKAY
    size R I IZ STRING'Z LEN YR contents MKAY BTW size = STRING.LEN(contents)
    BOTH SAEM size AN 0, O RLY?
        YA RLY, GTFO
    OIC
    linez R SMOOSH linez AN contents MKAY
IM OUTTA YR readLoop

BTW Close file
I IZ STDIO'Z CLOSE YR readFile MKAY

I HAS A linezLength ITZ I IZ STRING'Z LEN YR linez MKAY
VISIBLE SMOOSH "linez length: " AN linezLength MKAY
VISIBLE linez


KTHXBYE
HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

    OBTW
    STDIO has the following functions:
        OPEN - open a file
        DIAF - check for error (WIN/FAIL)
        LUK - read a file
        SCRIBBEL - write to a file
        AGEIN - reset the file pointer to the beginning (Calls C's rewind function)
        CLOSE - close a file
    TLDR
    

	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "TREATZ/8" AN YR "r" MKAY
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

	BTW Writing --------------------------------------------------------
	BTW This completely overwrites whatever was in the file in the first place
	I HAS A output ITZ "a,b,c,3:)d,e,f,5:)g,h,i,8"
	I HAS A writeFile ITZ I IZ STDIO'Z OPEN YR "TOYZ/BITZ_OF_YARN/writeOut" AN YR "w" MKAY
	I IZ STDIO'Z DIAF YR writeFile MKAY, O RLY?
		YA RLY, VISIBLE "Failed to open file for writing"
		NO WAI, VISIBLE "Successfully opened file for writing"
	OIC
	I IZ STDIO'Z SCRIBBEL YR writeFile AN YR output MKAY
	I IZ STDIO'Z SCRIBBEL YR writeFile AN YR "More text on same line" MKAY
	I IZ STDIO'Z SCRIBBEL YR writeFile AN YR ":)Write on a new line" MKAY
	I IZ STDIO'Z CLOSE YR writeFile MKAY
KTHXBYE
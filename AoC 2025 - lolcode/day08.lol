HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

BTW Open file
VISIBLE "Attempting to read file..."
I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "TREATZ/8" AN YR "r" MKAY
I IZ STDIO'Z DIAF YR readFile MKAY
O RLY?
	YA RLY
		VISIBLE "Failed to open file for reading"
	NO WAI
		VISIBLE "Successfully opened the file for reading"
OIC
BTW Assign the whole contents of the file to a YARN
I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 99999 MKAY
I IZ STDIO'Z CLOSE YR readFile MKAY
I HAS A endLoop ITZ I IZ STRING'Z LEN YR contents MKAY
VISIBLE "File size (chars):: " AN endLoop

HOW IZ I printArray YR bukkit
	IM IN YR printLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkit'Z LEN
		VISIBLE idx AN ":: " AN bukkit'Z SRS idx
	IM OUTTA YR printLoop
IF U SAY SO

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
	BTW Separate a YARN into a numerically indexed BUKKIT of YARNs using a delimiter
	I HAS A yarnSize ITZ I IZ STRING'Z LEN YR yarn MKAY
	DIFFRINT delimiter AN I IZ STRING'Z AT YR yarn AN YR DIFF OF yarnSize AN 1 MKAY
	O RLY?
		YA RLY
			yarn R SMOOSH yarn AN delimiter MKAY
			yarnSize R SUM OF yarnSize AN 1
	OIC
	I HAS A output ITZ A BUKKIT
	output HAS A LEN ITZ 0
	I HAS A buffer ITZ ""
	IM IN YR readLoop UPPIN YR idx TIL BOTH SAEM idx AN yarnSize
		I HAS A char ITZ I IZ STRING'Z AT YR yarn AN YR idx MKAY
		BOTH SAEM char AN delimiter, O RLY?
			YA RLY
				BTW new item
				I IZ isNumbr YR buffer MKAY, O RLY?
					YA RLY, buffer IS NOW A NUMBR
				OIC
				output HAS A SRS output'Z LEN ITZ buffer
				buffer R ""
				output'Z LEN R SUM OF output'Z LEN AN 1
			NO WAI
				buffer R SMOOSH buffer AN char MKAY
		OIC
	IM OUTTA YR readLoop
	FOUND YR output
IF U SAY SO

HOW IZ I READIN_CSV YR yarn
	I HAS A array ITZ I IZ READIN YR yarn AN YR ":)" MKAY
	I HAS A csvOutput ITZ A BUKKIT
	IM IN YR arrayLoop UPPIN YR arrayIdx TIL BOTH SAEM arrayIdx AN array'Z LEN
		I HAS A arrayYarn ITZ array'Z SRS arrayIdx
		I HAS A newBukkit ITZ I IZ READIN YR arrayYarn AN YR "," MKAY
		csvOutput HAS A SRS arrayIdx ITZ newBukkit
	IM OUTTA YR arrayLoop
	FOUND YR csvOutput
IF U SAY SO

VISIBLE "Parsing input..."
I HAS A KOORDINATEZ ITZ I IZ READIN_CSV YR contents MKAY
VISIBLE "... finished parsing."

VISIBLE "Computing..."
HOW IZ I dist YR coordinates1 AN YR coordinates2
	I HAS A x_dist ITZ DIFF OF coordinates1'Z SRS 0 AN coordinates2'Z SRS 0
	I HAS A y_dist ITZ DIFF OF coordinates1'Z SRS 1 AN coordinates2'Z SRS 1
	I HAS A z_dist ITZ DIFF OF coordinates1'Z SRS 2 AN coordinates2'Z SRS 2
	I HAS A x_dist_squared ITZ PRODUKT OF x_dist AN x_dist
	I HAS A y_dist_squared ITZ PRODUKT OF y_dist AN y_dist
	I HAS A z_dist_squared ITZ PRODUKT OF z_dist AN z_dist
	FOUND YR SUM OF SUM OF x_dist_squared AN y_dist_squared AN z_dist_squared
IF U SAY SO



VISIBLE "... finished computing."


VISIBLE "Finished."

KTHXBYE
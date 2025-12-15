HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

OBTW
Input today is a set of 3D coordinates, representing junction boxes 
which are to be connected using strings of fairy lights. The junction
boxes which are the closest distance are connected first. Any which
are already connected through other junction boxes ("transitivity"
in mathematical terms) are ignored.
TLDR

BTW Setup ----------------------------------------------------------------
I HAS A inputName ITZ "NOMNOMZ/8"
I HAS A calculateDistanceLookup ITZ WIN    BTW Switch between calculating or reading cached values
I HAS A sortDistanceLookup ITZ WIN 		BTW Switch between sorting or reading cached values

I HAS A target ITZ A NUMBR
I HAS A FILENAME ITZ A YARN
I HAS A maxDistance ITZ A NUMBR
I HAS A minDistance ITZ A NUMBR
inputName, WTF?
	OMG "NOMNOMZ/8"
		target R 1000
		FILENAME R "STASH/d08_dist_NOMNOMZ"
		minDistance R 769505
		maxDistance R 25172216750
		GTFO
	OMG "TREATZ/8"
		target R 10
		FILENAME R "STASH/d08_dist_TREATZ"
		minDistance R 100427
		maxDistance R 1990571
		GTFO
	OMGWTF
		VISIBLE "U HAZ RONG FILE, SILLY"
OIC
VISIBLE target

BTW Open file ------------------------------------------------------------
VISIBLE "Attempting to read file..."
I HAS A readFile ITZ I IZ STDIO'Z OPEN YR inputName AN YR "r" MKAY
I IZ STDIO'Z DIAF YR readFile MKAY
O RLY?
	YA RLY, VISIBLE "Failed to open file for reading"
	NO WAI, VISIBLE "Successfully opened the file for reading"
OIC

BTW Assign the whole contents of the file to a YARN
I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 99999 MKAY
VISIBLE "File size (chars):: " AN I IZ STRING'Z LEN YR contents MKAY
I IZ STDIO'Z CLOSE YR readFile MKAY

BTW Parsing inputs ------------------------------------------------------------

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
	BTW Creates a BUKKIT of BUKKITz, everything's indexed numerically from 0
	I HAS A array ITZ I IZ READIN YR yarn AN YR ":)" MKAY
	I HAS A csvOutput ITZ A BUKKIT
	csvOutput HAS A LEN ITZ array'Z LEN
	csvOutput HAS A SIZE ITZ array'Z LEN
	IM IN YR arrayLoop UPPIN YR arrayIdx TIL BOTH SAEM arrayIdx AN array'Z LEN
		I HAS A arrayYarn ITZ array'Z SRS arrayIdx
		I HAS A newBukkit ITZ I IZ READIN YR arrayYarn AN YR "," MKAY
		csvOutput HAS A SRS arrayIdx ITZ newBukkit
	IM OUTTA YR arrayLoop
	FOUND YR csvOutput
IF U SAY SO

HOW IZ I READ_DISTANCE_CSV YR filename
	BTW Read cached values instead
	BTW Open file
	VISIBLE "Attempting to read file..."
	I HAS A newReadFile ITZ I IZ STDIO'Z OPEN YR filename AN YR "r" MKAY
	I IZ STDIO'Z DIAF YR newReadFile MKAY
	O RLY?
		YA RLY, VISIBLE "Failed to open file for reading"
		NO WAI, VISIBLE "Successfully opened the file for reading"
	OIC

	BTW Assign the whole contents of the file to a YARN
	I HAS A lookupCsvYarn ITZ I IZ STDIO'Z LUK YR newReadFile AN YR 99999999999 MKAY
	I IZ STDIO'Z CLOSE YR newReadFile MKAY

	BTW Get the number of chars in the file for later parsing
	I HAS A endLoop ITZ I IZ STRING'Z LEN YR lookupCsvYarn MKAY 
	VISIBLE "File size (chars):: " AN endLoop

	BTW Turn back into a distanceLookup
	I HAS A table ITZ I IZ READIN_CSV YR lookupCsvYarn MKAY
	IM IN YR itemLoop UPPIN YR itemIdx TIL BOTH SAEM itemIdx AN table'Z SIZE
	BOTH SAEM 0 AN MOD OF itemIdx AN 1, O RLY?
		YA RLY, VISIBLE itemIdx
	OIC
		I HAS A item ITZ table'Z SRS itemIdx
		I HAS A distanceNTuple ITZ A BUKKIT
		distanceNTuple HAS A coords1 ITZ A BUKKIT
		distanceNTuple'Z coords1 HAS A SRS 0 ITZ item'Z SRS 0
		distanceNTuple'Z coords1 HAS A SRS 1 ITZ item'Z SRS 1
		distanceNTuple'Z coords1 HAS A SRS 2 ITZ item'Z SRS 2
		distanceNTuple HAS A coords2 ITZ A BUKKIT
		distanceNTuple'Z coords2 HAS A SRS 0 ITZ item'Z SRS 3
		distanceNTuple'Z coords2 HAS A SRS 1 ITZ item'Z SRS 4
		distanceNTuple'Z coords2 HAS A SRS 2 ITZ item'Z SRS 5
		distanceNTuple HAS A distance ITZ item'Z SRS 6
		BTW Add to DistanceLookup
		distanceLookup HAS A SRS distanceLookup'Z SIZE ITZ distanceNTuple
		distanceLookup'Z SIZE R SUM OF distanceLookup'Z SIZE AN 1
	IM OUTTA YR itemLoop
IF U SAY SO

VISIBLE "Parsing input..."
I HAS A KOORDINATEZ ITZ I IZ READIN_CSV YR contents MKAY
VISIBLE "... finished parsing."

BTW Calculating the distance between each pair of junction boxes - this takes several hours ---------------------------------------------------------------------
VISIBLE "Computing..."

HOW IZ I MEASURIN YR coordinates1 AN YR coordinates2
	BTW Produces a distance between two sets of coordinates (which are BUKKITs).
	BTW I am *not* writing a function to square-root but x^2+y^2+z^2 will do the job.
	I HAS A x_dist ITZ DIFF OF coordinates1'Z SRS 0 AN coordinates2'Z SRS 0
	I HAS A y_dist ITZ DIFF OF coordinates1'Z SRS 1 AN coordinates2'Z SRS 1
	I HAS A z_dist ITZ DIFF OF coordinates1'Z SRS 2 AN coordinates2'Z SRS 2
	I HAS A x_dist_squared ITZ PRODUKT OF x_dist AN x_dist
	I HAS A y_dist_squared ITZ PRODUKT OF y_dist AN y_dist
	I HAS A z_dist_squared ITZ PRODUKT OF z_dist AN z_dist
	FOUND YR SUM OF SUM OF x_dist_squared AN y_dist_squared AN z_dist_squared
IF U SAY SO

HOW IZ I WRITIN YR coordinates
	BTW Turns the coordinates (back) into a YARN for indexing
	I HAS A yarn ITZ SMOOSH coordinates'Z SRS 0 AN "," AN coordinates'Z SRS 1 AN "," AN coordinates'Z SRS 2 MKAY
	FOUND YR yarn
IF U SAY SO

O HAI IM CIRCUITZ
	I HAS A SIZE ITZ KOORDINATEZ'Z LEN
	I HAS A MAX ITZ 0
	I HAS A INDEX ITZ A BUKKIT
KTHX

BTW Populate a lookup of circuits, where the KEY is the coordinates-as-string, and the VALUE is the circuit (currently zero)
IM IN YR circuitzLoop UPPIN YR idx TIL BOTH SAEM idx AN KOORDINATEZ'Z LEN
	I HAS A yarn ITZ I IZ WRITIN YR KOORDINATEZ'Z SRS idx MKAY
	CIRCUITZ HAS A SRS yarn ITZ 0
	CIRCUITZ'Z INDEX HAS A SRS idx ITZ yarn
IM OUTTA YR circuitzLoop

O HAI IM distanceLookup
	I HAS A SIZE ITZ 0
	OBTW 
	Elements will look sort of like this:
	idx: (coords1, coords2, distance)
	TLDR


	HOW IZ I INDEXIN YR coordinates1 AN YR coordinates2
		BTW Returns the index of the two sets of coordinates from the lookup
		IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN SIZE
			I HAS A ntuple ITZ ME'Z SRS idx
			BOTH SAEM ntuple'Z coords1 AN coordinates1, O RLY?
				YA RLY
					BOTH SAEM ntuple'Z coords2 AN coordinates2, O RLY?
						YA RLY, FOUND YR idx
					OIC
			OIC
		IM OUTTA YR loop
		BTW if failed, try the coordinates the other way round
		IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN SIZE
			I HAS A ntuple ITZ ME'Z SRS idx
			BOTH SAEM ntuple'Z coords2 AN coordinates1, O RLY?
				YA RLY
					BOTH SAEM ntuple'Z coords1 AN coordinates2, O RLY?
						YA RLY, FOUND YR idx
					OIC
			OIC
		IM OUTTA YR loop
		VISIBLE "O NOEZ, MAI LOOKUP IZ INKOMPLEET"
	IF U SAY SO

	HOW IZ I MEASURIN YR coordinates1 AN YR coordinates2
		BTW Returns the distance between the two sets of coordinates from the lookup
		I HAS A idx ITZ I IZ INDEXIN YR coordinates1 AN YR coordinates2 MKAY
		I HAS A NTUPLE ITZ ME'Z SRS idx
		FOUND YR NTUPLE'Z distance
	IF U SAY SO

	HOW IZ I KOMBININ YR circuit1 AN YR circuit2
		BTW Every box which is in circuit1 will be assigned to circuit2
		I HAS A lookup ITZ CIRCUITZ'Z INDEX
		IM IN YR circuitLoop UPPIN YR idx TIL BOTH SAEM idx AN CIRCUITZ'Z SIZE
			I HAS A key ITZ lookup'Z SRS idx
			BOTH SAEM CIRCUITZ'Z SRS key AN circuit1, O RLY?
				YA RLY
					CIRCUITZ'Z SRS key R circuit2
			OIC
		IM OUTTA YR circuitLoop
	IF U SAY SO

	HOW IZ I KONNECTIN YR idx
		BTW "connects" two junction boxes 
		I HAS A NTUPLE ITZ ME'Z SRS idx

		I HAS A COORDS1 ITZ NTUPLE'Z coords1
		I HAS A COORDS1_YARN ITZ I IZ WRITIN YR COORDS1 MKAY
		I HAS A COORDS1_CIRCUIT ITZ CIRCUITZ'Z SRS COORDS1_YARN

		I HAS A COORDS2 ITZ NTUPLE'Z coords2
		I HAS A COORDS2_YARN ITZ I IZ WRITIN YR COORDS2 MKAY
		I HAS A COORDS2_CIRCUIT ITZ CIRCUITZ'Z SRS COORDS2_YARN

		BOTH OF BOTH SAEM 0 AN COORDS1_CIRCUIT AN BOTH SAEM 0 AN COORDS2_CIRCUIT, O RLY?
			YA RLY
				BTW Case 1: Both in no circuits (ID=0). Create a new circuit and add them.
				CIRCUITZ'Z MAX R SUM OF CIRCUITZ'Z MAX AN 1
				CIRCUITZ'Z SRS COORDS1_YARN R CIRCUITZ'Z MAX
				CIRCUITZ'Z SRS COORDS2_YARN R CIRCUITZ'Z MAX
				FOUND YR WIN
			MEBBE BOTH SAEM 0 AN COORDS1_CIRCUIT
				BTW Case 2a: One is in a circuit and the other isn't. Add the other to the circuit.
				CIRCUITZ'Z SRS COORDS1_YARN R COORDS2_CIRCUIT
				FOUND YR WIN
			MEBBE BOTH SAEM 0 AN COORDS2_CIRCUIT
				BTW Case 2b: One is in a circuit and the other isn't. Add the other to the circuit.
				CIRCUITZ'Z SRS COORDS2_YARN R COORDS1_CIRCUIT
				FOUND YR WIN
			NO WAI
				BTW Case 3: Both in different circuits. Combine the two circuits.
				ME IZ KOMBININ YR COORDS1_CIRCUIT AN YR COORDS2_CIRCUIT MKAY
				FOUND YR WIN
		OIC
		FOUND YR FAIL
	IF U SAY SO

	HOW IZ I COMPARE_CIRCUITZ YR idx
	BTW Returns a tuple of the circuits that the two junction boxes are connected to
		I HAS A NTUPLE ITZ ME'Z SRS idx

		I HAS A COORDS1 ITZ NTUPLE'Z coords1
		I HAS A COORDS1_YARN ITZ I IZ WRITIN YR COORDS1 MKAY
		I HAS A COORDS1_CIRCUIT ITZ CIRCUITZ'Z SRS COORDS1_YARN

		I HAS A COORDS2 ITZ NTUPLE'Z coords2
		I HAS A COORDS2_YARN ITZ I IZ WRITIN YR COORDS2 MKAY
		I HAS A COORDS2_CIRCUIT ITZ CIRCUITZ'Z SRS COORDS2_YARN

		I HAS A TWOPLE ITZ A BUKKIT
		TWOPLE HAS A SRS 0 ITZ COORDS1_CIRCUIT
		TWOPLE HAS A SRS 1 ITZ COORDS2_CIRCUIT

		FOUND YR TWOPLE
	IF U SAY SO

	HOW IZ I SAEM_CIRCUITZ YR idx
		BTW returns WIN if the junction boxes are already in the same circuit
		I HAS A TUPLE ITZ ME IZ COMPARE_CIRCUITZ YR idx MKAY
		BOTH SAEM 0 AN SMALLR OF TUPLE'Z SRS 0 AN TUPLE'Z SRS 1, O RLY?
			BTW One of these isn't in a circuit
			YA RLY, FOUND YR FAIL
		OIC
		FOUND YR BOTH SAEM TUPLE'Z SRS 0 AN TUPLE'Z SRS 1
	IF U SAY SO

	HOW IZ I GETTIN_CLOSEST
		BTW Returns index of coordinates which are the shortest distance and aren't already connected
		I HAS A lastIdx ITZ DIFF OF ME'Z SIZE AN 1
		I HAS A minDistIdx ITZ lastIdx
		IM IN YR searchLoop UPPIN YR pairIdx TIL BOTH SAEM pairIdx AN lastIdx
			BTW If already in same circuit, disregard
			ME IZ SAEM_CIRCUITZ YR pairIdx MKAY, O RLY?
				YA RLY
				NO WAI
					I HAS A currentWinningNTuple ITZ ME'Z SRS minDistIdx
					I HAS A currentSmallestDistance ITZ currentWinningNTuple'Z distance
					I HAS A thisNTuple ITZ ME'Z SRS pairIdx
					I HAS A thisDistance ITZ thisNTuple'Z distance
					BOTH SAEM thisDistance AN SMALLR OF thisDistance AN currentSmallestDistance, O RLY?
						YA RLY, minDistIdx R pairIdx
					OIC
			OIC
		IM OUTTA YR searchLoop
		FOUND YR minDistIdx
	IF U SAY SO

KTHX


OBTW
Step 1: Populate distance lookup

This takes like 2 hours or something to complete, so I'm going to write it to a cache and then read it from the cache
TLDR

VISIBLE "Creating distance lookup table..."
BTW Lower(?) triangular search will produce a lookup distance between any two sets of coordinates

BOTH OF calculateDistanceLookup AN sortDistanceLookup, O RLY?
	YA RLY
		BTW try to open file **here**, before you do half a million distance calculations
		I HAS A writeFile ITZ I IZ STDIO'Z OPEN YR FILENAME AN YR "w" MKAY
		I HAS A exception ITZ A NOOB   BTW Seems as good a way as any to create an exception...
		I IZ STDIO'Z DIAF YR writeFile MKAY, O RLY?
			YA RLY, VISIBLE "Failed to open file for writing", VISIBLE exception
			NO WAI, VISIBLE "Successfully opened " AN FILENAME AN " for writing"
		OIC

		IM IN YR coordsLoop1 UPPIN YR idx1 TIL BOTH SAEM idx1 AN KOORDINATEZ'Z LEN
			VISIBLE "idx1:: " AN idx1
			IM IN YR coordsLoop2 UPPIN YR idx2 TIL BOTH SAEM idx2 AN BIGGR OF idx1 AN idx2
				BTW create a ntuple of first coordinates, second coordinates, and distance between them
				I HAS A distanceNTuple ITZ A BUKKIT
				distanceNTuple HAS A coords1 ITZ KOORDINATEZ'Z SRS idx1
				I IZ STDIO'Z SCRIBBEL YR writeFile AN YR I IZ WRITIN YR distanceNTuple'Z coords1 MKAY MKAY
				I IZ STDIO'Z SCRIBBEL YR writeFile AN YR "," MKAY
				distanceNTuple HAS A coords2 ITZ KOORDINATEZ'Z SRS idx2
				I IZ STDIO'Z SCRIBBEL YR writeFile AN YR I IZ WRITIN YR distanceNTuple'Z coords2 MKAY MKAY
				I IZ STDIO'Z SCRIBBEL YR writeFile AN YR "," MKAY
				distanceNTuple HAS A distance ITZ I IZ MEASURIN YR distanceNTuple'Z coords1 AN YR distanceNTuple'Z coords2 MKAY
				I IZ STDIO'Z SCRIBBEL YR writeFile AN YR distanceNTuple'Z distance MKAY
				I IZ STDIO'Z SCRIBBEL YR writeFile AN YR ":)" MKAY
				BTW Add the ntuple to the lookup
				distanceLookup HAS A SRS distanceLookup'Z SIZE ITZ distanceNTuple
				distanceLookup'Z SIZE R SUM OF distanceLookup'Z SIZE AN 1
				BTW Write out
			IM OUTTA YR coordsLoop2
		IM OUTTA YR coordsLoop1

		BTW Write out to a file because this took bloody ages to compute
		I IZ STDIO'Z CLOSE YR writeFile MKAY
	MEBBE sortDistanceLookup
		BTW Read cached values instead
		VISIBLE "Reading unsorted distance lookup"
		I IZ READ_DISTANCE_CSV YR FILENAME MKAY
OIC

VISIBLE "... table complete."



OBTW
Step 2: Sort
TLDR

BTW Sorting algorithm stuff --------------------------------------------------------------

distanceLookup HAS A NAME ITZ "sorted"
distanceLookup HAS A MAX ITZ maxDistance BTW Cheating a bit here by looking at the cached file.
distanceLookup HAS A MIN ITZ minDistance BTW Cheating a bit here by looking at the cached file.

HOW IZ I PUTTIN YR b AN YR item AN YR numbr
	BTW adding a new element to a bukkit
	b HAS A SRS b'Z SIZE ITZ item
	b'Z MAX R BIGGR OF b'Z MAX AN numbr
	b'Z MIN R SMALLR OF b'Z MIN AN numbr
	b'Z SIZE R SUM OF b'Z SIZE AN 1
IF U SAY SO

HOW IZ I REASSIGNIN YR b AN YR item
	BTW Putting things back into a bukkit
	BTW we should be putting the same number of things back into the bukkit
	b'Z SRS b'Z SIZE R item
	b'Z SIZE R SUM OF b'Z SIZE AN 1
IF U SAY SO

HOW IZ I REMOVIN YR b AN YR idx
	b'Z SRS idx R NOOB
	b'Z SIZE R DIFF OF b'Z SIZE AN 1
IF U SAY SO

HOW IZ I ALL_SAEM YR b
	I HAS A item_0 ITZ b'Z SRS 0
	IM IN YR elementLoop UPPIN YR idx TIL BOTH SAEM idx AN b'Z SIZE
		I HAS A item ITZ b'Z SRS idx
		DIFFRINT item_0'Z distance AN item'Z distance, O RLY?
			YA RLY, FOUND YR FAIL
		OIC
	IM OUTTA YR elementLoop
	FOUND YR WIN
IF U SAY SO


HOW IZ I GETTIN_NEW_BUKKIT YR name
	OBTW
	Creates an empty bukkit with fresh values for SIZE, MAX, and NAME
	TLDR
	I HAS A new_bukkit ITZ A BUKKIT
	new_bukkit HAS A SIZE ITZ 0
	new_bukkit HAS A MAX ITZ 0 BTW <--- max value for each element
	new_bukkit HAS A MIN ITZ 99999999999 BTW <--- min value for each element
	new_bukkit HAS A NAME ITZ name
	FOUND YR new_bukkit
IF U SAY SO

HOW IZ I GET_BUKKIT_INTERVALS YR b
OBTW
	0. Bukkitz need to split the interval between MAX and MIN
	1. Want at most 10 bukkitz
	2. If fewer than 10 items, want that number of bukkitz
TLDR
	I HAS A intervalSize ITZ SUM OF 1 AN DIFF OF outerBukkit'Z MAX AN outerBukkit'Z MIN
	I HAS A numbrOfBukkitz ITZ SMALLR OF intervalSize AN SMALLR OF outerBukkit'Z SIZE AN 10
	I HAS A bukkitSize ITZ QUOSHUNT OF intervalSize AN DIFF OF numbrOfBukkitz AN 1
IF U SAY SO

HOW IZ I CREATE_SET_OF_EMPTY_BUKKITZ YR outerBukkit
	OBTW
		0. Bukkitz need to split the interval between MAX and MIN
		1. Want at most 10 bukkitz
		2. If fewer than 10 items, want that number of bukkitz
	TLDR
	BTW Name recursively, so you'll get sorted_0 to sorted_9, then sorted_0_0 to sorted_0_9 to sorted_9_0 to sorted_9_9, etc
	I HAS A intervalSize ITZ SUM OF 1 AN DIFF OF outerBukkit'Z MAX AN outerBukkit'Z MIN
	I HAS A numbrOfBukkitz ITZ SMALLR OF intervalSize AN SMALLR OF outerBukkit'Z SIZE AN 10
	I HAS A bukkitSize ITZ QUOSHUNT OF intervalSize AN numbrOfBukkitz 
	IM IN YR createBukkitzLoop UPPIN YR newBukkitIdx TIL BOTH SAEM newBukkitIdx AN numbrOfBukkitz
		I HAS A bukkitName ITZ SMOOSH outerBukkit'Z NAME AN "_" AN newBukkitIdx MKAY
		I HAS A newBukkit ITZ I IZ GETTIN_NEW_BUKKIT YR bukkitName MKAY
		outerBukkit HAS A SRS bukkitName ITZ newBukkit
	IM OUTTA YR createBukkitzLoop
IF U SAY SO

HOW IZ I SORT_INTO_BUKKITZ YR outerBukkit
	I HAS A intervalSize ITZ SUM OF 1 AN DIFF OF outerBukkit'Z MAX AN outerBukkit'Z MIN
	I HAS A numbrOfBukkitz ITZ SMALLR OF intervalSize AN SMALLR OF outerBukkit'Z SIZE AN 10
	I HAS A bukkitSize ITZ QUOSHUNT OF intervalSize AN numbrOfBukkitz 
	BTW Start sorting things into BUKKITZ
	I HAS A infiniteLoopException ITZ A NOOB
	I HAS A loopMax ITZ outerBukkit'Z SIZE
	BTW loop through each element in the outer bukkit and assign to the inner bukkitz
	IM IN YR elementLoop UPPIN YR elementIdx TIL BOTH SAEM elementIdx AN loopMax
		I HAS A tuple ITZ outerBukkit'Z SRS elementIdx
		I HAS A valueToBeSorted ITZ tuple'Z distance
		I HAS A assigned ITZ FAIL
		IM IN YR bukkitLoop UPPIN YR bukkitIdx TIL BOTH SAEM assigned AN WIN
			BOTH SAEM bukkitIdx AN numbrOfBukkitz, O RLY?
				YA RLY, VISIBLE "Infinite looooop", VISIBLE infiniteLoopException
			OIC

			I HAS A bukkitMaxValue ITZ SUM OF outerBukkit'Z MIN AN PRODUKT OF bukkitSize AN SUM OF bukkitIdx AN 1
			DIFFRINT valueToBeSorted AN BIGGR OF valueToBeSorted AN bukkitMaxValue, O RLY?
				YA RLY
					I HAS A bukkitName ITZ SMOOSH outerBukkit'Z NAME AN "_" AN bukkitIdx MKAY
					I HAS A bukkit ITZ outerBukkit'Z SRS bukkitName
					I IZ PUTTIN YR bukkit AN YR tuple AN YR valueToBeSorted MKAY
					assigned R WIN
				MEBBE BOTH SAEM bukkitIdx AN DIFF OF numbrOfBukkitz AN 1
					BTW Last bukkit - don't worry about max value
					I HAS A bukkitName ITZ SMOOSH outerBukkit'Z NAME AN "_" AN bukkitIdx MKAY
					I HAS A bukkit ITZ outerBukkit'Z SRS bukkitName
					I IZ PUTTIN YR bukkit AN YR tuple AN YR valueToBeSorted MKAY
					assigned R WIN
			OIC
		IM OUTTA YR bukkitLoop
	IM OUTTA YR elementLoop
IF U SAY SO

HOW IZ I SORTIN YR bukkitOfNumbrz
	I IZ CREATE_SET_OF_EMPTY_BUKKITZ YR bukkitOfNumbrz MKAY

	I IZ SORT_INTO_BUKKITZ YR bukkitOfNumbrz MKAY

	I HAS A intervalSize ITZ SUM OF 1 AN DIFF OF bukkitOfNumbrz'Z MAX AN bukkitOfNumbrz'Z MIN
	I HAS A numbrOfBukkitz ITZ SMALLR OF intervalSize AN SMALLR OF bukkitOfNumbrz'Z SIZE AN 10
	I HAS A bukkitSize ITZ QUOSHUNT OF intervalSize AN numbrOfBukkitz 
	I HAS A loopMax ITZ bukkitOfNumbrz'Z SIZE
	IM IN YR elementLoop UPPIN YR elementIdx TIL BOTH SAEM elementIdx AN loopMax
		BTW Closest we can get to manual garbage collection is deallocation
		I IZ REMOVIN YR bukkitOfNumbrz AN YR elementIdx MKAY
	IM OUTTA YR elementLoop

	IM IN YR bukkitSizeLoop UPPIN YR bukkitIdx TIL BOTH SAEM bukkitIdx AN numbrOfBukkitz
		I HAS A bukkitName ITZ SMOOSH bukkitOfNumbrz'Z NAME AN "_" AN bukkitIdx MKAY
		I HAS A bukkit ITZ bukkitOfNumbrz'Z SRS bukkitName

		BTW Recursion - sort the new buckets in the same way until they contain at most one element
		DIFFRINT 1 AN BIGGR OF bukkit'Z SIZE AN 1, O RLY?
			YA RLY 
				I IZ ALL_SAEM YR bukkit MKAY, O RLY?
					YA RLY
					NO WAI, I IZ SORTIN YR bukkit MKAY
				OIC
		OIC
		BTW Finally, re-assign all the values in order. Use recursion because it's easier.
		IM IN YR elementLoop UPPIN YR elementIdx TIL BOTH SAEM elementIdx AN bukkit'Z SIZE
			I IZ REASSIGNIN YR bukkitOfNumbrz AN YR bukkit'Z SRS elementIdx MKAY
		IM OUTTA YR elementLoop
		I HAS A max ITZ bukkit'Z SIZE
		IM IN YR elementLoop UPPIN YR elementIdx TIL BOTH SAEM elementIdx AN max
			I IZ REMOVIN YR bukkit AN YR elementIdx MKAY
		IM OUTTA YR elementLoop
	IM OUTTA YR bukkitSizeLoop
IF U SAY SO

BTW Sort the distanceLookup table and write out the sorted values, or read in the sorted values
I HAS A sortedFilename ITZ SMOOSH FILENAME AN "_sorted" MKAY
sortDistanceLookup, O RLY?
	YA RLY
		VISIBLE "Sorting the lookup table"
		I IZ SORTIN YR distanceLookup MKAY
		VISIBLE "... sorted."

		I HAS A writeFile ITZ I IZ STDIO'Z OPEN YR sortedFilename AN YR "w" MKAY
		I IZ STDIO'Z DIAF YR writeFile MKAY, O RLY?
			YA RLY, VISIBLE "Failed to open file for writing"
			NO WAI, VISIBLE "Successfully opened file for writing"
		OIC
		IM IN YR elementLoop UPPIN YR idx TIL BOTH SAEM idx AN distanceLookup'Z SIZE
			I HAS A distanceNTuple ITZ distanceLookup'Z SRS idx
			I IZ STDIO'Z SCRIBBEL YR writeFile AN YR I IZ WRITIN YR distanceNTuple'Z coords1 MKAY MKAY
			I IZ STDIO'Z SCRIBBEL YR writeFile AN YR "," MKAY
			I IZ STDIO'Z SCRIBBEL YR writeFile AN YR I IZ WRITIN YR distanceNTuple'Z coords2 MKAY MKAY
			I IZ STDIO'Z SCRIBBEL YR writeFile AN YR "," MKAY
			I IZ STDIO'Z SCRIBBEL YR writeFile AN YR distanceNTuple'Z distance MKAY
			I IZ STDIO'Z SCRIBBEL YR writeFile AN YR ":)" MKAY
		IM OUTTA YR elementLoop
		I IZ STDIO'Z CLOSE YR writeFile MKAY
	NO WAI
		VISIBLE "Reading sorted distance lookup"
		I IZ READ_DISTANCE_CSV YR sortedFilename MKAY

OIC

BTW -------------------------------------------------------------

OBTW
Step 3: Connect junction boxes
TLDR

I HAS A connectionCount ITZ 0

VISIBLE "Pairing up the junction boxes..."
IM IN YR distanceLookupLoop UPPIN YR idx TIL BOTH SAEM connectionCount AN DIFF OF target AN 1
	BTW Print progress to console
	BOTH SAEM 100 AN BIGGR OF 100 AN connectionCount, O RLY?
		YA RLY, VISIBLE connectionCount
		MEBBE BOTH SAEM 0 AN MOD OF connectionCount AN 100
			VISIBLE connectionCount
	OIC
	distanceLookup IZ SAEM_CIRCUITZ YR idx MKAY, O RLY?
		YA RLY BTW In same circuit - don't connect
		NO WAI
			I HAS A tuple ITZ distanceLookup'Z SRS idx
			BTW Not in same circuit - connect
			distanceLookup IZ KONNECTIN YR idx MKAY
			BTW Check for success, and increase connectionCount
			O RLY?
				YA RLY, connectionCount R SUM OF connectionCount AN 1
				NO WAI, VISIBLE "oh no"
			OIC

	OIC

IM OUTTA YR distanceLookupLoop

VISIBLE "... we're out of fairy lights!"


I HAS A count ITZ A BUKKIT
IM IN YR countLoop UPPIN YR idx TIL BOTH SAEM idx AN SUM OF CIRCUITZ'Z MAX AN 1
	count HAS A SRS idx ITZ 0
IM OUTTA YR countLoop

I HAS A lookup ITZ CIRCUITZ'Z INDEX
IM IN YR circuitLoop UPPIN YR idx TIL BOTH SAEM idx AN CIRCUITZ'Z SIZE
	I HAS A key ITZ lookup'Z SRS idx
	count'Z SRS CIRCUITZ'Z SRS key R SUM OF count'Z SRS CIRCUITZ'Z SRS key AN 1
IM OUTTA YR circuitLoop

I HAS A largestCircuitSize ITZ 0
I HAS A secondLargestCircuitSize ITZ 0
I HAS A thirdLargestCircuitSize ITZ 0

IM IN YR countLoop UPPIN YR idx TIL BOTH SAEM idx AN SUM OF CIRCUITZ'Z MAX AN 1
DIFFRINT idx AN 0, O RLY?
	YA RLY, DIFFRINT count'Z SRS idx AN 0, O RLY?
		YA RLY
			DIFFRINT largestCircuitSize AN BIGGR OF largestCircuitSize AN count'Z SRS idx, O RLY?
				YA RLY
					thirdLargestCircuitSize R secondLargestCircuitSize
					secondLargestCircuitSize R largestCircuitSize
					largestCircuitSize R count'Z SRS idx
				MEBBE DIFFRINT secondLargestCircuitSize AN BIGGR OF secondLargestCircuitSize AN count'Z SRS idx
					thirdLargestCircuitSize R secondLargestCircuitSize
					secondLargestCircuitSize R largestCircuitSize
				MEBBE DIFFRINT thirdLargestCircuitSize AN BIGGR OF thirdLargestCircuitSize AN count'Z SRS idx
					thirdLargestCircuitSize R count'Z SRS idx
			OIC
	OIC
OIC
IM OUTTA YR countLoop



VISIBLE "... finished computing."

VISIBLE "Answer:: " AN PRODUKT OF PRODUKT OF largestCircuitSize AN secondLargestCircuitSize AN thirdLargestCircuitSize

VISIBLE "Finished."

KTHXBYE
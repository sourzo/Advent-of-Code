HAI 1.3
CAN HAS STDIO?
CAN HAS STRING?

BTW Open file
I HAS A readFile ITZ I IZ STDIO'Z OPEN YR "NOMNOMZ/4" AN YR "r" MKAY
I IZ STDIO'Z DIAF YR readFile MKAY
O RLY?
	YA RLY
		VISIBLE "Failed to open file for reading"
	NO WAI
		VISIBLE "Successfully opened the file for reading"
OIC
BTW Assign the whole contents of the file to a YARN
I HAS A contents ITZ I IZ STDIO'Z LUK YR readFile AN YR 99999 MKAY
I HAS A endLoop ITZ I IZ STRING'Z LEN YR contents MKAY
VISIBLE "File size (chars): " AN endLoop

VISIBLE "Parsing input..."
OBTW
The input is "diagram" of the room layout, 
where @ symbols are rolls of paper, and dots are blank spaces.
TLDR

HOW IZ I isPaper YR char
    BTW VISIBLE "isPaper " AN char
    BOTH SAEM char AN "@", O RLY?
        YA RLY, FOUND YR WIN
        NO WAI, FOUND YR FAIL
    OIC
IF U SAY SO

HOW IZ I isPaperOrSpace YR char
    BTW VISIBLE "isPaperOrSpace " AN char
    I IZ isPaper YR char MKAY, O RLY?
        YA RLY, FOUND YR WIN
    OIC
    BOTH SAEM char AN ".", O RLY?
        YA RLY, FOUND YR WIN
        NO WAI, FOUND YR FAIL
    OIC
IF U SAY SO

I HAS A diagram ITZ A BUKKIT
I HAS A rows ITZ 0
I HAS A cols ITZ 0
diagram HAS A SRS 0 ITZ A BUKKIT BTW first row

IM IN YR readLoop UPPIN YR idx TIL BOTH SAEM idx AN SUM OF endLoop AN 1
    I HAS A symbol ITZ I IZ STRING'Z AT YR contents AN YR idx MKAY
    BOTH SAEM symbol AN ":)", O RLY?
        YA RLY
            BTW new row
            rows R SUM OF rows AN 1
            diagram HAS A SRS rows ITZ A BUKKIT BTW Add new row
            cols R 0
        MEBBE I IZ isPaperOrSpace YR symbol MKAY
            BTW Add to diagram
            diagram'Z SRS rows HAS A SRS cols ITZ symbol
            cols R SUM OF cols AN 1
    OIC
IM OUTTA YR readLoop
rows R SUM OF rows AN 1 BTW fix off-by-one
BTW VISIBLE rows
BTW VISIBLE cols
VISIBLE "... finished parsing."

HOW IZ I countPoint YR row AN YR col
    BTW VISIBLE "countPoint " AN row AN " " AN col
    I HAS A thisRow ITZ diagram'Z SRS row
    I IZ isPaper YR thisRow'Z SRS col MKAY, O RLY?
        YA RLY, FOUND YR 1
        NO WAI, FOUND YR 0
    OIC
IF U SAY SO

HOW IZ I countRow YR row AN YR col
    BTW VISIBLE "countRow " AN row AN " " AN col
    BTW On a single row, count all paper in each of the three columns
    I HAS A paperCount ITZ 0
    I HAS A leftColumn ITZ DIFF OF col AN 1
    I HAS A rightColumn ITZ SUM OF col AN 1
    BTW middle column - always count
    paperCount R SUM OF paperCount AN I IZ countPoint YR row AN YR col MKAY
    DIFFRINT col AN 0, O RLY?
        YA RLY
            BTW Not first column - count the column to the left
            paperCount R SUM OF paperCount AN I IZ countPoint YR row AN YR leftColumn MKAY
    OIC
    DIFFRINT col AN DIFF OF cols AN 1, O RLY?
        YA RLY
            BTW Not last column - count the column to the right
            paperCount R SUM OF paperCount AN I IZ countPoint YR row AN YR rightColumn MKAY
        NO WAI
    OIC
    FOUND YR paperCount
IF U SAY SO

HOW IZ I countNeighbours YR row AN YR col
    BTW VISIBLE "countNeighbours " AN row AN " " AN col
    OBTW
        Count how much paper is in the eight neighbouring positions surrounding the reference row and col.
    TLDR
    I HAS A paperCount ITZ 0
    I HAS A topRow ITZ DIFF OF row AN 1
    I HAS A bottomRow ITZ SUM OF row AN 1
    BTW middle row - always count
    paperCount R SUM OF paperCount AN I IZ countRow YR row AN YR col MKAY
    DIFFRINT row AN 0, O RLY?
        YA RLY
            BTW Not first row - count the row above
            paperCount R SUM OF paperCount AN I IZ countRow YR topRow AN YR col MKAY
    OIC
    DIFFRINT row AN DIFF OF rows AN 1, O RLY?
        YA RLY
            BTW Not last row - count the row below
            paperCount R SUM OF paperCount AN I IZ countRow YR bottomRow AN YR col MKAY
    OIC
    BTW Correct for whatever is in the middle of the square
    paperCount R DIFF OF paperCount AN I IZ countPoint YR row AN YR col MKAY
    FOUND YR paperCount
IF U SAY SO

VISIBLE "Computing..."
HOW IZ I COUNT_ACCESSIBLE_PAPER
    I HAS A countAccessiblePaper ITZ 0
    IM IN YR rowLoop UPPIN YR rowIdx TIL BOTH SAEM rowIdx AN rows
        IM IN YR colLoop UPPIN YR colIdx TIL BOTH SAEM colIdx AN cols
            I HAS A thisRow ITZ diagram'Z SRS rowIdx
            I IZ isPaper YR thisRow'Z SRS colIdx MKAY, O RLY?
                YA RLY
                    I HAS A countAllPaper ITZ I IZ countNeighbours YR rowIdx AN YR colIdx MKAY
                    DIFFRINT countAllPaper AN BIGGR OF countAllPaper AN 4, O RLY?
                        YA RLY
                            countAccessiblePaper R SUM OF countAccessiblePaper AN 1
                    OIC
            OIC
            
        IM OUTTA YR colLoop
    IM OUTTA YR rowLoop
    FOUND YR countAccessiblePaper
IF U SAY SO
VISIBLE "Accessible paper count: " AN I IZ COUNT_ACCESSIBLE_PAPER MKAY
VISIBLE "... finished computing."

OBTW Part 2 - remove accessible paper until no more can be removed TLDR

VISIBLE "Removing accessible paper..."
HOW IZ I REMOVE_ACCESSIBLE_PAPER
    I HAS A foundAccessiblePaper ITZ FAIL
    IM IN YR rowLoop UPPIN YR rowIdx TIL BOTH SAEM rowIdx AN rows
        IM IN YR colLoop UPPIN YR colIdx TIL BOTH SAEM colIdx AN cols
            I HAS A thisRow ITZ diagram'Z SRS rowIdx
            I IZ isPaper YR thisRow'Z SRS colIdx MKAY, O RLY?
                YA RLY
                    I HAS A countAllPaper ITZ I IZ countNeighbours YR rowIdx AN YR colIdx MKAY
                    DIFFRINT countAllPaper AN BIGGR OF countAllPaper AN 4, O RLY?
                        YA RLY
                            foundAccessiblePaper R WIN
                            thisRow'Z SRS colIdx R "."
                            removeCount R SUM OF removeCount AN 1
                    OIC
            OIC
            
        IM OUTTA YR colLoop
    IM OUTTA YR rowLoop
    FOUND YR foundAccessiblePaper
IF U SAY SO

I HAS A finished ITZ FAIL
I HAS A removeCount ITZ 0
IM IN YR removingPaperLoop UPPIN YR idx TIL BOTH SAEM finished AN WIN
    finished R NOT I IZ REMOVE_ACCESSIBLE_PAPER MKAY
IM OUTTA YR removingPaperLoop

VISIBLE "Removed paper count: " AN removeCount
VISIBLE "... finished computing."


VISIBLE "Finished."
KTHXBYE
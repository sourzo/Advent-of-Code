HAI 1.3
CAN HAS STRING?
CAN HAS STDLIB?

    OBTW
        Q: What's a LOLCODEr's favourite sorting algorithm?
        A: BUKKIT sort!
    TLDR

    HOW IZ I PUTTIN YR b AN YR numbr
        BTW adding a new element to a bukkit
        b HAS A SRS b'Z SIZE ITZ numbr
        b'Z MAX R BIGGR OF b'Z MAX AN numbr
        b'Z SIZE R SUM OF b'Z SIZE AN 1
    IF U SAY SO

    HOW IZ I REASSIGNIN YR b AN YR numbr
        BTW Putting things back into a bukkit
        BTW we should be putting the same number of things back into the bukkit
        b'Z SRS b'Z SIZE R numbr
        b'Z MAX R BIGGR OF b'Z MAX AN numbr
        b'Z SIZE R SUM OF b'Z SIZE AN 1
    IF U SAY SO

    HOW IZ I REMOVIN YR b AN YR idx
        b'Z SRS idx R NOOB
        b'Z SIZE R DIFF OF b'Z SIZE AN 1
    IF U SAY SO

    HOW IZ I ALL_SAEM YR b
        IM IN YR elementLoop UPPIN YR idx TIL BOTH SAEM idx AN b'Z SIZE
            DIFFRINT b'Z SRS 0 AN b'Z SRS idx, O RLY?
                YA RLY, FOUND YR FAIL
            OIC
        IM OUTTA YR elementLoop
        FOUND YR WIN
    IF U SAY SO


    HOW IZ I LUK YR b
        OBTW 
        Prints all the elements in the bukkit as long as they're printable.
        If the element is a bukkit then it's not printable
        TLDR
        I HAS A output ITZ ""
        IM IN YR printLoop UPPIN YR elementIdx TIL BOTH SAEM elementIdx AN b'Z SIZE
            output R SMOOSH output AN b'Z SRS elementIdx AN ", " MKAY
        IM OUTTA YR printLoop
        VISIBLE output AN "(Bukkit size: " AN b'Z SIZE AN ")"
    IF U SAY SO

    HOW IZ I GETTIN_NEW_BUKKIT YR name
        OBTW
        Creates an empty bukkit with fresh values for SIZE, MAX, and NAME
        TLDR
        I HAS A new_bukkit ITZ A BUKKIT
        new_bukkit HAS A SIZE ITZ 0
        new_bukkit HAS A MAX ITZ 0 BTW <--- max value for each element
        new_bukkit HAS A NAME ITZ name
        FOUND YR new_bukkit
    IF U SAY SO

    HOW IZ I CREATE_SET_OF_EMPTY_BUKKITZ YR outerBukkit
        BTW Create 10 BUKKITs of mostly equal interval size
        BTW Name recursively, so you'll get sorted_0 to sorted_9, then sorted_0_0 to sorted_0_9 to sorted_9_0 to sorted_9_9, etc
        I HAS A numbrOfBukkitz ITZ SMALLR OF outerBukkit'Z SIZE AN 10
        I HAS A bukkitSize ITZ QUOSHUNT OF outerBukkit'Z MAX AN DIFF OF numbrOfBukkitz AN 1
        IM IN YR createBukkitzLoop UPPIN YR newBukkitIdx TIL BOTH SAEM newBukkitIdx AN numbrOfBukkitz
            I HAS A bukkitName ITZ SMOOSH outerBukkit'Z NAME AN "_" AN newBukkitIdx MKAY
            I HAS A newBukkit ITZ I IZ GETTIN_NEW_BUKKIT YR bukkitName MKAY
            outerBukkit HAS A SRS bukkitName ITZ newBukkit
        IM OUTTA YR createBukkitzLoop
    IF U SAY SO

    HOW IZ I SORT_INTO_BUKKITZ YR outerBukkit
        I HAS A numbrOfBukkitz ITZ SMALLR OF outerBukkit'Z SIZE AN 10
        I HAS A bukkitSize ITZ QUOSHUNT OF outerBukkit'Z MAX AN DIFF OF numbrOfBukkitz AN 1
        BTW Start sorting things into BUKKITZ
        I HAS A infiniteLoopException ITZ A NOOB
        I HAS A loopMax ITZ outerBukkit'Z SIZE
        BTW loop through each element in the outer bukkit and assign to the inner bukkitz
        IM IN YR elementLoop UPPIN YR elementIdx TIL BOTH SAEM elementIdx AN loopMax
            BTW VISIBLE elementIdx AN " ... " AN loopMax
            I HAS A assigned ITZ FAIL
            IM IN YR bukkitLoop UPPIN YR bukkitIdx TIL BOTH SAEM assigned AN WIN
                BOTH SAEM bukkitIdx AN SUM OF numbrOfBukkitz AN 1, O RLY?
                    YA RLY, VISIBLE "Infinite looooop", VISIBLE infiniteLoopException
                OIC

                I HAS A bukkitMaxValue ITZ PRODUKT OF bukkitSize AN SUM OF bukkitIdx AN 1
                I HAS A valueToBeSorted ITZ outerBukkit'Z SRS elementIdx
                DIFFRINT valueToBeSorted AN BIGGR OF valueToBeSorted AN bukkitMaxValue, O RLY?
                    YA RLY
                        I HAS A bukkitName ITZ SMOOSH outerBukkit'Z NAME AN "_" AN bukkitIdx MKAY
                        I HAS A bukkit ITZ outerBukkit'Z SRS bukkitName
                        I IZ PUTTIN YR bukkit AN YR valueToBeSorted MKAY
                        assigned R WIN
                OIC
            IM OUTTA YR bukkitLoop
        IM OUTTA YR elementLoop
    IF U SAY SO

    HOW IZ I SORTIN YR bukkitOfNumbrz
        I IZ CREATE_SET_OF_EMPTY_BUKKITZ YR bukkitOfNumbrz MKAY

        I IZ SORT_INTO_BUKKITZ YR bukkitOfNumbrz MKAY

        I HAS A numbrOfBukkitz ITZ SMALLR OF bukkitOfNumbrz'Z SIZE AN 10
        I HAS A bukkitSize ITZ QUOSHUNT OF bukkitOfNumbrz'Z MAX AN DIFF OF numbrOfBukkitz AN 1
        I HAS A loopMax ITZ bukkitOfNumbrz'Z SIZE
        IM IN YR elementLoop UPPIN YR elementIdx TIL BOTH SAEM elementIdx AN loopMax
            BTW Closest we can get to manual garbage collection is deallocation
            I IZ REMOVIN YR bukkitOfNumbrz AN YR elementIdx MKAY
        IM OUTTA YR elementLoop

        IM IN YR bukkitSizeLoop UPPIN YR bukkitIdx TIL BOTH SAEM bukkitIdx AN numbrOfBukkitz
            I HAS A bukkitName ITZ SMOOSH bukkitOfNumbrz'Z NAME AN "_" AN bukkitIdx MKAY
            BTW VISIBLE bukkitName
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



    BTW Test!
    I HAS A max ITZ 22

    BTW Create a BUKKIT and populate it with random numbers
    I HAS A testBukkit ITZ I IZ GETTIN_NEW_BUKKIT YR "sorted" MKAY
    IM IN YR creationLoop UPPIN YR idx TIL BOTH SAEM idx AN max
        I HAS A randomNumber ITZ I IZ STDLIB'Z BLOW YR PRODUKT OF max AN 10 MKAY
        I IZ PUTTIN YR testBukkit AN YR randomNumber MKAY
    IM OUTTA YR creationLoop

    VISIBLE "Sorting a BUKKIT of size " AN testBukkit'Z SIZE
    I IZ SORTIN YR testBukkit MKAY
    VISIBLE "Finished sorting!"

    I IZ LUK YR testBukkit MKAY
    VISIBLE "All done!"
KTHXBYE
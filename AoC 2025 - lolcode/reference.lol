HAI 1.3
CAN HAS STDIO? BTW Loads the module. Except I'm not sure it does?
CAN HAS STRING?
    BTW This is a single-line comment

    OBTW This is a comment block
    Look at it, wheeee
    TLDR

    BTW declare a variable
    I HAS A var ITZ A YARN
    BTW assign a value
    var R "2"
    BTW declare and assign
    I HAS A nother_var ITZ "Kitty"
    BTW cast
    var IS NOW A NUMBR
    BTW print
    VISIBLE nother_var
    VISIBLE SUM OF var AN 5

    BTW class definition
    O HAI IM className
        BTW stuff goes here
    KTHX

    BTW function definition
    HOW IZ I FUNCTION_NAME YR arg1 AN YR arg2 
        BTW stuff goes here, eg:
        I HAS A output ITZ SUM OF arg1 AN arg2
        BTW return statement
        FOUND YR output 
    IF U SAY SO

    BTW call function
    I IZ FUNCTION_NAME YR 2 AN YR 3 MKAY
    BTW Use MKAY at the end of non-simple statements, e.g. more than one argument, or a function within a function (eg VISIBLE I IZ...)

    BTW use a function from a package or class
    VISIBLE I IZ STRING'Z LEN YR nother_var
    BTW General syntax: I IZ <CLASSNAME>'Z <FUNCTION> YR arg1

    BTW input from console
    I HAS A kittyName
    VISIBLE "WATS UR NAME"
    GIMMEH kittyName
    
    BTW Control flow: If/Then/Else
    BOTH SAEM kittyName AN "WAFFLES", O RLY?    BTW if
        YA RLY                                  BTW then
            VISIBLE "IZ GREAT NAME"
        MEBBE BOTH SAEM kittyName AN "NEIL"     BTW else if
            VISIBLE "IZ TERRIBLE NAME"
        NO WAI                                  BTW else
            VISIBLE "HAI " AN kittyName
    OIC                                         BTW end if

    BTW Read a file
    I HAS A inputPath ITZ "TREATZ/1"
    I HAS A readFile ITZ I IZ STDIO'Z OPEN YR inputPath AN YR "r" MKAY
    BTW Check it worked
    I IZ STDIO'Z DIAF YR readFile MKAY          BTW DIAF = Die In A Fire. Lovely!
    O RLY?
        YA RLY
            VISIBLE "WHERE FIEL"                BTW file not found
        NO WAI
            VISIBLE "THERE FIEL"                BTW file opened
    OIC
    
    BTW An important bit of metaprogramming! SRS turns a value into a var name
    I HAS A SRS "fjsnfgosngj" ITZ 123
    VISIBLE "SRS returns " AN fjsnfgosngj

    BTW The BUKKIT (array)
    I HAS A book ITZ A BUKKIT
    book HAS A pageCount ITZ 300
    book HAS A bookmark ITZ 144
    book HAS A title ITZ "Famous Cats of History"

    O HAI IM book
        I HAS A pageCount ITZ 300
        I HAS A bookmark ITZ 1
        I HAS A title ITZ "Famous Cats of History"
    KTHX

    BTW The STRING package
    BTW Length
    VISIBLE I IZ STRING'Z LEN YR "PsPsPs"
    BTW Index from 0
    VISIBLE I IZ STRING'Z AT YR "Whiskas" AN YR 1 MKAY
    BTW This slice doesn't work for me but I've seen it in code:
    BTW I IZ STRING'Z SLICE YR "StringThing" AN YR 0 AN YR 5 MKAY
KTHXBYE
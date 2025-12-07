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
    VISIBLE "Printing things to the terminal...."
    VISIBLE nother_var
    VISIBLE SUM OF var AN 5
    BTW Concatenation
    VISIBLE SMOOSH "The sum of 2 and 8 is " AN 10 MKAY

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
    BTW The new line character is a smiley :) as shown in lots of print statements below
    VISIBLE ":)Calling the LEN function from the STRING module..."
    VISIBLE I IZ STRING'Z LEN YR nother_var MKAY
    BTW General syntax: I IZ <CLASSNAME>'Z <FUNCTION> YR arg1 YR arg2 YR arg3 MKAY

    BTW input from console
    VISIBLE ":)Getting input from the console..."
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

    VISIBLE ":)Opening a file..."
    BTW Read a file
    I HAS A inputPath ITZ "TREATZ/1"
    I HAS A readFile ITZ I IZ STDIO'Z OPEN YR inputPath AN YR "r" MKAY
    BTW Check it worked
    I IZ STDIO'Z DIAF YR readFile MKAY          BTW DIAF = Die In A Fire. Lovely! Returns WIN/FAIL depending on whether the file failed to open
    O RLY?                                      BTW WIN/FAIL test on the last unassigned expression (which is the line above this one)
        YA RLY
            VISIBLE "WHERE FIEL"                BTW file not found
        NO WAI
            VISIBLE "THERE FIEL"                BTW file opened
    OIC
    
    BTW An important bit of metaprogramming! SRS turns a value into a var name
    VISIBLE ":)Testing the SRS token to see what it does..."
    I HAS A SRS "fjsnfgosngj" ITZ 123
    VISIBLE "SRS returns " AN fjsnfgosngj

    OBTW 
    The BUKKIT (container object? class?)
    You can assign properties to it
    You can also assign functions to it
    To get the value of a property, the syntax is <bukkitObject>'Z <propertyThing>
    To call a function, it's <bukkitObject>'Z I IZ <functionThing> YR .... MKAY
    TLDR

    VISIBLE ":)Bukkits! How do they work?"
    I HAS A book ITZ A BUKKIT
    book HAS A pageCount ITZ 300
    book HAS A bookmark ITZ 144
    book HAS A title ITZ "Famous Cats of History"

    O HAI IM book2
        I HAS A pageCount ITZ 9999
        I HAS A bookmark ITZ 4
        I HAS A title ITZ "Famous Cats of History vol 2"
    KTHX

    VISIBLE book'Z title

    OBTW
        Most importantly, you can treat it like an array by creating a variable for each index
        You use SRS to assign values
    TLDR

    VISIBLE ":)Arrays, which are really just BUKKITs"
    I HAS A squareNumbersArray ITZ A BUKKIT
    IM IN YR arrayLoop UPPIN YR idx TIL BOTH SAEM idx AN 5
        squareNumbersArray HAS A SRS idx ITZ PRODUKT OF idx AN idx
        BTW this creates variables inside array called 0, 1, 2, 3, 4 and 5
        BTW which in this example all just have the value "blahblahblah"
    IM OUTTA YR arrayLoop

    VISIBLE squareNumbersArray'Z SRS 4

    VISIBLE ":)The STRING package"
    BTW The STRING package
    BTW Length
    VISIBLE I IZ STRING'Z LEN YR "PsPsPs" MKAY
    BTW Index from 0
    VISIBLE I IZ STRING'Z AT YR "Whiskas" AN YR 1 MKAY
    BTW This slice doesn't work for me but I've seen it in code:
    BTW I IZ STRING'Z SLICE YR "StringThing" AN YR 0 AN YR 5 MKAY
KTHXBYE
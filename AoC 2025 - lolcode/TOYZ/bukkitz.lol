HAI 1.3
	HOW IZ I printArrayofPrimitives YR bukkit
		IM IN YR printLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkit'Z SIZE
			VISIBLE idx AN ":: " AN bukkit'Z SRS idx
		IM OUTTA YR printLoop
	IF U SAY SO

	HOW IZ I printArrayofBukkitz YR bukkit
		IM IN YR printLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkit'Z SIZE
			VISIBLE idx 
			VISIBLE I IZ printArrayofPrimitives YR bukkit'Z SRS idx MKAY
		IM OUTTA YR printLoop
	IF U SAY SO

	HOW IZ I CREATE_EMPTY YR bukkitLength
		OBTW
			Creates a new BUKKIT with a given number of enumerated empty slots
			bukkitLength: the number of empty slots to create
		TLDR
		I HAS A output ITZ A BUKKIT
		output HAS A SIZE ITZ bukkitLength
		IM IN YR slotLoop UPPIN YR idx TIL BOTH SAEM idx AN bukkitLength
			output HAS A SRS idx ITZ A NOOB
		IM OUTTA YR slotLoop
		FOUND YR output
	IF U SAY SO

KTHXBYE
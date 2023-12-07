/^.+$/ {
	cards = getCards($1)
	score = getScore(cards) cards
	hands[score] = 0 + $2	
}

END {
	asorti(hands, ohands)

	total = 0
	for (h in ohands) {
		total += (hands[ohands[h]] * h)
	}

	print "Total = " total
}

function getScore(hand) {

	delete group

	patsplit(hand, handCards, ".{2}")
	for (c = 1; c <= 5; c++) {
		group[handCards[c]]++
	}

	noGroups = 0
	hasJacks = 0
	for (g in group) {
		if (g == "01") {
			hasJacks = group[g]
		} else {
			noGroups++
		}
	}

	switch (noGroups) {
		case 0: return "7"; break
		case 1: return "7"; break
		case 2: 
			for (g in group) {
				if ((group[g] + hasJacks) == 4) return "6"
			} 
			return "5"
			break
		case 3: 
			for (g in group) {
				if ((group[g] + hasJacks) == 3) return "4"
			} 
			return "3"
			break
		case 4: return "2"; break
		case 5: return "1"; break
	}
}

function getCards(hand) {
	cards = ""
	split(hand, handCards, "")
	for (c in handCards) {
		switch (handCards[c]) {
			case "A": cards = cards "14"
			break
			
			case "K": cards = cards "13"
			break
			
			case "Q": cards = cards "12"
			break
			
			case "J": cards = cards "01"
			break
			
			case "T": cards = cards "10"
			break
			
			default: cards = cards "0" handCards[c]
			break
			
		}
	}
	return cards
}

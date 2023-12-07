/^.+$/ {
	score = getScore($1)
	cards = getCards($1, score)
	hands[cards] = 0 + $2	
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

	split(hand, handCards, "")
	for (c = 1; c <= 5; c++) {
		group[handCards[c]]++
	}

	noGroups = 0
	for (g in group) {
		noGroups++
	}

	switch (noGroups) {
		case 1: return "7"; break
		case 2: 
			for (g in group) {
				if (group[g] == 4) return "6"
			} 
			return "5"
			break
		case 3: 
			for (g in group) {
				if (group[g] == 3) return "4"
			} 
			return "3"
			break
		case 4: return "2"; break
		case 5: return "1"; break
	}
}

function getCards(hand, score) {
	split(hand, handCards, "")
	for (c in handCards) {
		switch (handCards[c]) {
			case "A": score = score "14"
			break
			
			case "K": score = score "13"
			break
			
			case "Q": score = score "12"
			break
			
			case "J": score = score "11"
			break
			
			case "T": score = score "10"
			break
			
			default: score = score "0" handCards[c]
			break
			
		}
	}
	return 0 + score
}

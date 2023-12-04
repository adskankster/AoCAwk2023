BEGIN { FS = "(:|\\|)"; total = 0 }

/^Card.*$/ {
	cards[NR]["count"] = 1
	noWinners = split($2, cards[NR]["winners"], " +")
	noNumbers = split($3, cards[NR]["numbers"], " +")

	cardTotal = 0

	total += cardTotal
}

END {
	for (c in cards) {
		for (s = 1; s <= cards[c]["count"]; s ++) {
			matched = processCard(cards[c]["winners"], cards[c]["numbers"])	
			for (i = 1; i <= matched; i++) {
				cards[c+i]["count"]++
			}
		}
	}

	for (c in cards) {
		total += cards[c]["count"]
	}
	print "Total = " total

}

function processCard(winners, numbers) {
	matched = 0
	for (n in numbers) {
		if (numbers[n] == "") continue

		for (w in winners) {
			if (numbers[n] == winners[w]) {
				matched++
				break
			}
		}
	}
	return matched
}

BEGIN { FS = "(:|\\|)"; total = 0 }

/^Card.*$/ {
	noWinners = split($2, winners, " +")
	noNumbers = split($3, numbers, " +")

	cardTotal = 0

	for (n in numbers) {
		if (numbers[n] == "") continue

		for (w in winners) {
			if (numbers[n] == winners[w]) {
				if (cardTotal == 0) {
					cardTotal = 1
				} else {
					cardTotal *= 2
				}
				break
			}
		}
	}
	total += cardTotal
}

END {
	print "Total = " total

}

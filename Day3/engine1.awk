BEGIN { FS = ""; total = 0 }

/^.+$/ {
	for (x = 1; x <= NF; x++) {
		found = match($x, "[^1234567890\.]")
		if (found != 0) 
		{
			symbol[NR][x] = $x
		}

		found = match($x, "[[:digit:]]")
		if (found != 0) {
			number[NR][x]["total"] = $x
			number[NR][x]["length"] = 1
			delta = 1
			while (match($(x + delta), "[[:digit:]]") != 0)
			{
				number[NR][x]["total"] = number[NR][x]["total"] $(x + delta)
				number[NR][x]["length"] = ++delta
			}
			x +=  (delta - 1)
		}
	}
}

END { 
	for (y in number) {
		for (h = (y - 1); h <= (y + 1); h++) {
			if (h in symbol) {
				for (x in  number[y]) {
					for (p = (x - 1); p <= (x + number[y][x]["length"]); p++) {
						if (p in symbol[h]) {
							total += number[y][x]["total"]
							break
						}
					}
				}
			}
		}
	}

	print "total = " total 
}

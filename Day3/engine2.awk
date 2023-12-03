BEGIN { FS = ""; total = 0 }

/^.*\*+.*$/ {
	for (x = 1; x <= NF; x++) {
		if ($x == "*") {
			gear[NR][x][1] = "0"
			gear[NR][x][2] = "0"
		}
	}
}

/^.*[[:digit:]].*$/ {

	for (x = 1; x <= NF; x++) {

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
			if (h in gear) {
				for (x in  number[y]) {
					for (p = (x - 1); p <= (x + number[y][x]["length"]); p++) {
						if (p in gear[h]) {
							if (gear[h][p][1] == 0) {
								gear[h][p][1] = number[y][x]["total"]
							} else {
								if (gear[h][p][2] == 0) {
									gear[h][p][2] = number[y][x]["total"]
								} else {
									gear[h][p][1] = -1
									gear[h][p][2] = -1 
								}
							}
							break
						}
					}
				}
			}
		}
	}

	for (y in gear) {
		for (x in gear[y]) {
			if (gear[y][x][1] > 0 && gear[y][x][2] > 0) {
				total += gear[y][x][1] * gear[y][x][2]
			}
		}
	}

	print "total = " total 
}

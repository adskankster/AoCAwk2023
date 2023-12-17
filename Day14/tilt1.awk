BEGIN { FS = ""; noRocks = 0; }

/^.+$/ {
	for (x = 1; x <= NF; x++) {
		map[x][NR] = $x
	}
	map[0][0] = NF
}

END {
	for (x = 1; x <= map[0][0]; x++) {
		for (y = 1; y <= NR; y++) {
			if (map[x][y] == "O") {
				dy = y - 1
				while (map[x][dy] == ".") {
					map[x][dy] = "O"
					map[x][dy + 1] = "."
					dy--
				}
			}
		}
	} 
	
	total = 0
	multiplier = NR

	for (wy = 1; wy <= NR; wy++) {
		rowTotal = 0
		for (wx = 1; wx <= map[0][0]; wx++) {
			if (map[wx][wy] == "O") {
				rowTotal += multiplier
			}
		}
		total += rowTotal
		multiplier--
	}

	print "Total = " total
}

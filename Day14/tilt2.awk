BEGIN { FS = ""; noRocks = 0; }

/^.+$/ {
	for (x = 1; x <= NF; x++) {
		map[x][NR] = $x
	}
	map[0][0] = NF
}

END {

	for (c = 1; c <= 1000000000; c++) {
		tiltN()
		tiltW()
		tiltS()
		tiltE()
		if (c % 100000 == 0) printf("0%10i\r", c)
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


function tiltN() {
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
}

function tiltE() {
	for (y = 1; y <= NR; y++) {
		for (x = 1; x <= map[0][0]; x++) {
			if (map[x][y] == "O") {
				dx = x + 1
				while (map[dx][y] == ".") {
					map[dx][y] = "O"
					map[dx - 1][y] = "."
					dx++
				}
			}
		}
	} 
}

function tiltS() {
	for (x = 1; x <= map[0][0]; x++) {
		for (y = NR; y > 0; y--) {
			if (map[x][y] == "O") {
				dy = y + 1
				while (map[x][dy] == ".") {
					map[x][dy] = "O"
					map[x][dy - 1] = "."
					dy++
				}
			}
		}
	} 
}

function tiltW() {
	for (y = 1; y <= NR; y++) {
		for (x = map[0][0]; x > 0; x--) {
			if (map[x][y] == "O") {
				dx = x - 1
				while (map[dx][y] == ".") {
					map[dx][y] = "O"
					map[dx+1][y] = "."
					dx--
				}
			}
		}
	} 
}


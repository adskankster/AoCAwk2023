BEGIN { FS = "" }

/^.*$/ {
	maxE = NF
	for (x = 1; x <= NF; x++) {
		switch ($x) {
			case "S":
				startY = NR; startX = x
				map[NR][x]["N"] = 1
				map[NR][x]["E"] = 1
				map[NR][x]["S"] = 1
				map[NR][x]["W"] = 1
			break

			case ".":
				map[NR][x]["N"] = 0
				map[NR][x]["E"] = 0
				map[NR][x]["S"] = 0
				map[NR][x]["W"] = 0
			break

			case "|":
				map[NR][x]["N"] = 1
				map[NR][x]["E"] = 0
				map[NR][x]["S"] = 1
				map[NR][x]["W"] = 0
			break

			case "-":
				map[NR][x]["N"] = 0
				map[NR][x]["E"] = 1
				map[NR][x]["S"] = 0
				map[NR][x]["W"] = 1
			break

			case "L":
				map[NR][x]["N"] = 1
				map[NR][x]["E"] = 1
				map[NR][x]["S"] = 0
				map[NR][x]["W"] = 0
			break

			case "J":
				map[NR][x]["N"] = 1
				map[NR][x]["E"] = 0
				map[NR][x]["S"] = 0
				map[NR][x]["W"] = 1
			break

			case "7":
				map[NR][x]["N"] = 0
				map[NR][x]["E"] = 0
				map[NR][x]["S"] = 1
				map[NR][x]["W"] = 1
			break

			case "F":
				map[NR][x]["N"] = 0
				map[NR][x]["E"] = 1
				map[NR][x]["S"] = 1
				map[NR][x]["W"] = 0
			break
		}
	}
}


END {
# This doesn't cope with gaps around the corner. Needs re-doing.
exit
	curY = startY; curX = startX
	
	lastMove = start()
	steps = 1

	do {
		lastMove = move(lastMove)
		steps++
		grid[curY][curX] = steps
	} while (curY != startY || curX != startX)
	print "Loop length = " steps

	for (y = 1; y <= maxE; y++) {
		for (x = 1; x <= NR; x ++) {
			if (y in grid && x in grid[y]) continue
			print y ", " x " not in loop"
			nonLoop[y][x] = 1
		}
	}

	count = 0
	for (y in nonLoop) {
		for (x in nonLoop[y]) {
			count += checkNonLoop(y, x)
			print "NonLoop " y ", " x ": " count
		}
	}

	print "Total " count
}

function checkNonLoop(y, x) {
	if (checkNBound(x, y) == 1 && 
	    checkSBound(x, y) == 1 && 
	    checkEBound(x, y) == 1 && 
	    checkWBound(x, y) == 1) return 1
}

function checkNBound(x, y) {
	if (checkVert(x, 1, y - 1) == 2) {
		return 1
	}
	return 0
}

function checkSBound(x, y) {
	if (checkVert(x, y + 1, NR) == 2) {
		return 1
	}
	return 0
}

function checkEBound(x, y) {
	if (checkHori(y, x + 1, maxE) == 2) {
		return 1
	}
	return 0
}

function checkWBound(x, y) {
	if (checkHori(y, 1, x - 1) == 2) {
		return 1
	}
	return 0
}

function checkVert(x, start, stop) {
	boundE = 0
	boundW = 0

	if (start >= stop) return 0

	for (vy = start; vy != stop; vy++) {
		if (vy in grid && x in grid[vy]) {
print y ", " x ": EW " map[vy][x]["E"] ". " map[vy][x]["W"] 
			if (map[vy][x]["E"] == 1) boundE = 1
			if (map[vy][x]["W"] == 1) boundW = 1
			if (boundE + boundW == 2) break
		}	
	}
	return boundE + boundW
}

function checkHori(y, start, stop) {
	boundN = 0
	boundS = 0

	if (start >= stop) return 0

	for (hx = start; hx != stop; hx++) {
		if (y in grid && hx in grid[y]) {
print y ", " x ": NS " map[y][hx]["N"] ". " map[y][hx]["S"] 
			if (map[y][hx]["N"] == 1) boundN = 1
			if (map[y][hx]["S"] == 1) boundS = 1
			if (boundN + boundS == 2) break
		}	
	}
	return boundN + boundS
}

function checkNorth (x, y) {
	if (y == 1) return 0
	return map[y - 1][x]["S"] 
}

function checkSouth (x, y) {
	if (y == NR) return 0
	return map[y + 1][x]["N"] 
}

function checkEast (x, y) {
	if (x == maxE) return 0
	return map[y][x + 1]["W"] 
}

function checkWest (x, y) {
	if (x == 1) return 0
	return map[y][x - 1]["E"] 
}

function move(lastMove) {

	if (curY != NR && lastMove != "N" && map[curY][curX]["S"] == 1) {
		curY++
		return "S"
	}

	if (curX != 1 && lastMove != "E" && map[curY][curX]["W"] == 1) {
		curX--
		return "W"
	}

	if (curY != 1 && lastMove != "S" && map[curY][curX]["N"] == 1) {
		curY--
		return "N"
	}

	if (curX != maxE && lastMove != "W" && map[curY][curX]["E"] == 1) {
		curX++
		return "E"
	}
}

function  start() {

	if (checkNorth(curX, curY) == 1) {
		curY--
		return "N"
	}
	
	if (checkSouth(curX, curY) == 1) {
		curY++
		return "S"
	}
	
	if (checkEast(curX, curY) == 1) {
		curX++
		return "E"
	}
	
	if (checkWest(curX, curY) == 1) {
		curX--
		return "W"
	}
}

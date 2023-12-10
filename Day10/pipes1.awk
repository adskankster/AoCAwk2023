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
	curY = startY; curX = startX
	
	lastMove = start()
	steps = 1

	do {
		lastMove = move(lastMove)
		steps++
	} while (curY != startY || curX != startX)
	
	print "Total steps = " steps
	print "Halfway = " steps / 2
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
print curY ", " curX ": " lastMove

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

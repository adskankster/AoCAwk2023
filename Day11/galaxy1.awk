BEGIN { FS = ""; noGalaxies = 0; noRows = 0 }

/^.*#+.*$/ {
	addRow($0)
}

/^[^#]+$/ {
	addEmptyRow()
}

END {
	expandMap()
	
	totalSteps = 0
	for (g = 1; g < noGalaxies; g++) {
		for (gg = g + 1; gg <= noGalaxies; gg++) {
			vsteps = galaxies[g]["y"] - galaxies[gg]["y"]
			if (vsteps < 0) vsteps *= -1
			hsteps =  galaxies[g]["x"] - galaxies[gg]["x"]
			if (hsteps < 0) hsteps *= -1

			steps = vsteps + hsteps
			
			print g "-"gg " = " vsteps " + " hsteps " = " steps
			totalSteps += steps
		}
	}
	
	print "Total steps = " totalSteps
}

function addRow(rowStr,    x) {
	noCols = split(rowStr, row, "")

	noRows++
	for (x = 1; x <= noCols; x++) {
		map[noRows][x] = row[x]
		if (row[x] == "#") {
			galaxies[++noGalaxies]["x"] = x
			galaxies[noGalaxies]["y"] = noRows

			occupiedCol[x]++
		}
	}
}

function addEmptyRow(    x,y) {
	noCols = split(rowStr, row, "")

	for (y = 1; y <= 2; y++) {
		noRows++
		for (x = 1; x <= noCols; x++) {
			map[noRows][x] = "."
		}
	}
}

function expandMap(    x,y) {
	for (x in map[1]) {
		if (x in occupiedCol) continue
		emptyCol[x] = 1
	}
	
	for (fg in galaxies) {
		adjustment = 0
		for (ec in emptyCol) {
			if (galaxies[fg]["x"] > ec) {
				adjustment++
			}
		}
		galaxies[fg]["x"] += adjustment
		print fg ": " galaxies[fg]["y"] ", " galaxies[fg]["x"] 
	}
}

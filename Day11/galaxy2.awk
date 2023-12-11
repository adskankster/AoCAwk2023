BEGIN { FS = ""; noGalaxies = 0 }

/^.*#+.*$/ {
	addRow(NR,$0)
}

/^[^#]+$/ {
	addEmptyRow(NR)
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

function addRow(noRows, rowStr,    x) {
	noCols = split(rowStr, row, "")

	for (x = 1; x <= noCols; x++) {
		map[noRows][x] = row[x]
		if (row[x] == "#") {
			galaxies[++noGalaxies]["x"] = x
			galaxies[noGalaxies]["y"] = noRows

			occupiedCol[x]++
		}
	}
}

function addEmptyRow(noRows,    x,y) {
	emptyRows[noRows] = 1
}

function expandMap(    x,y) {
	for (x in map[1]) {
		if (x in occupiedCol) continue
		emptyCol[x] = 1
	}
	
	for (fg in galaxies) {
		hadjustment = 0
		for (ec in emptyCol) {
			if (galaxies[fg]["x"] > ec) {
				hadjustment += 999999
			}
		}
		galaxies[fg]["x"] += hadjustment

		vadjustment = 0
		for (er in emptyRows) {
			if (galaxies[fg]["y"] > er) {
				vadjustment += 999999
			}	
		}
		galaxies[fg]["y"] += vadjustment

		print fg ": " galaxies[fg]["y"] ", " galaxies[fg]["x"] 
	}
}

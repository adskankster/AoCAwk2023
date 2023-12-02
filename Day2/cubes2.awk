BEGIN {
	FS = "(:|;)"
	total = 0
}

/^Game/ {
	min["red"] = 0
	min["green"] = 0
	min["blue"] = 0

	for (grab = 2; grab <= NF; grab++) {
		colours = split($grab, balls, ",")
		for(ball = 1; ball <= colours; ball++) {
			bf = split(balls[ball], fields, " ")

			if (fields[2] in min) {
				if (fields[1] > min[fields[2]]) {
					min[fields[2]] = fields[1]
				}
			}		
		}
	}

	power = min["red"] * min["green"] * min["blue"]
	total += power
}


END { print "total = " total }

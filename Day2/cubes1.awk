BEGIN {
	FS = "(:|;|Game)"
	total = 0

	max["red"] = 12
	max["green"] = 13
	max["blue"] = 14
}

/^.+$/ {
	for (grab = 3; grab <= NF; grab++) {
		colours = split($grab, balls, ",")
		for(ball = 1; ball <= colours; ball++) {
			bf = split(balls[ball], fields, " ")

			if (fields[2] in max) {
				if (fields[1] > max[fields[2]]) {
					next
				}
			}		
		}
	}

	total += $2
}


END { print "total = " total }

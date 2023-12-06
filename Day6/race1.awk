/^Time:/ { 
	for (r = 2; r <= NF; r++) {
		race[r]["time"] = $r
	}
}


/^Distance:/ { 
	for (r = 2; r <= NF; r++) {
		race[r]["distance"] = $r
	}
}

END {
	total = 1
	for (r in race) {
		n = 0
		for (t = 1; t < race[r]["time"]; t++) {
			d = t * (race[r]["time"] - t)
			if (d > race[r]["distance"]) n++
		}
		total *= n
	}

	print "Total = " total
}

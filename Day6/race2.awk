BEGIN { FS = ":" }

/^Time:/ { 
	gsub(" +", "", $2)
	time = 0 +  $2
print time
}


/^Distance:/ { 
	gsub(" +", "", $2)
	distance = 0 + $2
print distance
}

END {
	total = 0
	for (t = 1; t < time; t++) {
		d = t * (time - t)
		if (d > distance) total++
	}

	print "Total = " total
}

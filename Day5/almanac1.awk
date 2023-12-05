BEGIN { }

/seeds:/ { 
	for (s = 1; s <= NF; s++) {
		seeds[s] = $(s+1)
	}
}

/^.+map:/ {
	split($1, mapping, "-")
	currentSource = mapping[1]
	currentTarget = mapping[3]

	map[currentSource] = currentTarget
}

/^[[:digit:]]+/ {
	almanac[currentSource][0 + $2]["length"] = $3
	almanac[currentSource][0 + $2]["destination"] = $1
}

END {
	nearest = 10000000000;
	for (seed in seeds) {
		currentSource = "seed"
		currentDestination = map[currentSource]	
		source = seeds[seed]
		destination = getDestination(currentSource, source)

		while (currentDestination != "location") {
			currentSource = currentDestination
			currentDestination = map[currentSource]	
			destination = getDestination(currentSource, destination)
		}
		if (destination < nearest) nearest = destination
	}

	print "nearest = " nearest
}

function getDestination(currentSource, source) {
	for (start in almanac[currentSource]) {
		if ((source - start) >= 0 && (source <= (start + almanac[currentSource][start]["length"]))) {
			return almanac[currentSource][start]["destination"] + (source - start)
		} 
	}
	return source
}

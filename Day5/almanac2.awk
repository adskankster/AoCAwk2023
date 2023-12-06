/seeds:/ { 
	for (s = 2; s <= NF; s += 2) {
		seeds[$s] = $(s+1)
	}
}

/^.+map:/ {
	split($1, mapping, "-")
	currentSource = mapping[1]
	currentDestination = mapping[3]

	map[currentDestination] = currentSource
}

/^[[:digit:]]+/ {
	almanac[currentDestination][0 + $1]["length"] = $3
	almanac[currentDestination][0 + $1]["source"] = $2
}

END {
	for (location = 11611100; location <= 11611184; location++) {
		destination = location
		currentDestination = "location"
		currentSource = map[currentDestination]
		source = getSource(currentDestination, destination)

		while (currentSource != "seed") {
			currentDestination = currentSource
			currentSource = map[currentDestination]
			source = getSource(currentDestination, source)
		}
		for (seed in seeds) {
			seedEnd = seed + seeds[seed]
			if (source >= seed && source <= seedEnd) {
				print seed ", " seedEnd
				print "maps to " source
				print "nearest = " location
				exit
			}
		}
		if ((location % 1000000000) == 0) {
			print location " maps to " source " which is not in range"
		}
	}
}

function getSource(currentDestination, destination) {
	for (start in almanac[currentDestination]) {
		if ((destination - start) >= 0 && (destination <= (start + almanac[currentDestination][start]["length"]))) {
			return almanac[currentDestination][start]["source"] + (destination - start)
		}
	}
	return destination 
}



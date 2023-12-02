@include "../functions/stringFunctions.awk"
BEGIN { total = 0 
	FPAT = "(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine){1}"
	numbers["one"] = 1; numbers["1"] = 1
	numbers["two"] = 2; numbers["2"] = 2
	numbers["three"] = 3; numbers["3"] = 3
	numbers["four"] = 4; numbers["4"] = 4
	numbers["five"] = 5; numbers["5"] = 5
	numbers["six"] = 6; numbers["6"] = 6
	numbers["seven"] = 7; numbers["7"] = 7
	numbers["eight"] = 8; numbers["8"] = 8
	numbers["nine"] = 9; numbers["9"] = 9
}
/^.*(1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine).*$/ {
	first = $1
	if ($1 in numbers) {
		first = numbers[$1]
	}

	lastItem = 0
	for (toFind in numbers) {
		li = lastIndexOf($0, toFind) 
		if (li > lastItem) {
			lastItem = li
			last = toFind
		}	
	}

	last = numbers[last]

	#print $0 " = "$1 ", " first ", " lastItem  ", "  last
	total += (first last)
}

END { print "total = " total }

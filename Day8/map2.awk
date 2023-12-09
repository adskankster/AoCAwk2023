NR == 1 { 
	insCount = length($0)
	patsplit($0, instructions, "(R|L){1}")

	FPAT = "[[:alnum:]]{3}" 
}

/^[[:alnum:]]{3} / {
	nodes[$1]["L"] = $2
	nodes[$1]["R"] = $3
}


END {
	noPaths = getStartNodes(curNodes)
	for (cn in curNodes) {
		steps[cn] = 0
		curIns = 1
		curEndNodes = 0
		maxCount = 0
	
		#while (noPaths != curEndNodes) {
		while (substr(curNodes[cn], 3) != "Z") {
			instruction = instructions[curIns]
	
			curNodes[cn] = nodes[curNodes[cn]][instruction]
			steps[cn]++
			if (++curIns > insCount) curIns = 1
		}
	
		print "Total steps[" cn "] = " steps[cn]
	}

	lcm = getLCMM(steps, 1)

	print "LCM = " lcm
}

function getStartNodes(curNodes) {

	count = 0
	for (n in nodes) {
		if (substr(n, 3) == "A") {
			curNodes[++count] = n
		}
	}
	return count
}

function getLCMM(values, i) {
	if (i + 1 == 6) {
		return getLCM(values[i], values[i+1])
	} else {
		return getLCM(values[i], getLCMM(values, i+1))
	}
}

function getLCM(a, b) {
	return a * b / gcd(a, b)
}

function gcd(a, b) {
	while (b != 0) {
		tmp = b
		b = a % b
		a = tmp
	}
	return a
}

NR == 1 { 
	insCount = length($0)
	patsplit($0, instructions, "(R|L){1}")

	FPAT = "[A-Z]{3}" 
}

/^[A-Z]{3} / {
	nodes[$1]["L"] = $2
	nodes[$1]["R"] = $3
}

END {
	curNode = "AAA"
	steps = 0
	curIns = 1

	while (curNode != "ZZZ") {
		instruction = instructions[curIns]
		curNode = nodes[curNode][instruction]
		steps++
		if (++curIns > insCount) curIns = 1
	}

	printf("Total %s steps", steps)

}

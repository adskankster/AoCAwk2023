BEGIN { 
	FS=",";  
}

/^.+$/ {
	for (i = 1; i <= NF; i++) {
		mindex = match($i, /(-|=)/)
		codes[i]["label"] = substr($i, 1, mindex - 1)
		codes[i]["action"] = substr($i, mindex, 1)
		codes[i]["power"] = substr($i, mindex + 1) + 0
	}
}

END {
	total = 0

	for (i in codes) {
		box = 0
		x = split(codes[i]["label"], code, "") 
		for (c = 1; c <= x; c++) {
			box = hash(subTotal, code[c])
			print "box = " box
		}
		
		if (codes[i]["label"] in boxes[box]) {
			if (codes[i]["action"] == "-") {
				delete boxes[box][codes[i]["label"]]
			} else {
				boxes[box][codes[i]["label"]]["label"] = codes[i]["label"]
				boxes[box][codes[i]["label"]]["power"] = codes[i]["power"]
			}
		} else {
			if (codes[i]["action"] == "=") {
				print "add " codes[i]["power"] " to boxes[" box "][" codes[i]["label"] "]"
				boxes[box][codes[i]["label"]]["label"] = codes[i]["label"]
				boxes[box][codes[i]["label"]]["power"] = codes[i]["power"]
			}
		}
	}

	bMult = 0
	for (b in boxes) {
		sMult = 0
		bMult++
		boxTotal = 0
		for (s in boxes[b]) {
			sMult++
			
			print b "-" s ": " boxes[b][s]["label"] " - " bMult " * " sMult  " * " boxes[b][s]["power"]
			boxTotal += (boxes[b][s]["power"] * bMult * sMult)
		}
		total += boxTotal
	}
	
	print "Total = " total
}

function hash(rTot, code,      o, ot, otm, otmf) {
	o = ord(code)
	ot = rTot + o
	otm = ot * 17
	otmf = otm % 256
	return otmf
}

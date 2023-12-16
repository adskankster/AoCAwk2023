BEGIN { 
	FS=",";  
	for (b = 0; b < 256; b++) {
		boxes[b][0] = 0
	}
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
			box = hash(box, code[c])
			print "box = " box
		}

		inslot = 0 
		for (j = 1; j <= boxes[box][0]; j++) {
			if (j in boxes[box] &&
			   boxes[box][j]["label"] == codes[i]["label"]) {
				inslot = j
				break
			}
		}
		
		if (inslot > 0) {
			if (codes[i]["action"] == "-") {
				delete boxes[box][inslot]
			} else {
				boxes[box][inslot]["label"] = codes[i]["label"]
				boxes[box][inslot]["power"] = codes[i]["power"]
			}
		} else {
			if (codes[i]["action"] == "=") {
				boxes[box][0]++
				boxes[box][boxes[box][0]]["label"] = codes[i]["label"]
				boxes[box][boxes[box][0]]["power"] = codes[i]["power"]
			}
		}
	}

	bMult = 0
	for (b in boxes) {
		sMult = 0
		bMult++
		boxTotal = 0
		for (s = 1; s <= boxes[b][0]; s++) {
			if (s in boxes[b]) {
				sMult++
			
				boxTotal += (boxes[b][s]["power"] * bMult * sMult)
			}
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

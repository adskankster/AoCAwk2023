BEGIN { FS="," }

/^.+$/ {
	for (i = 1; i <= NF; i++) {
		codes[i] = $i
	}
}

END {
	total = 0

	for (i in codes) {
		subTotal = 0
		x = split(codes[i], code, "") 
		for (c = 1; c <= x; c++) {
			subTotal = hash(subTotal, code[c])
		}
		total += subTotal
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

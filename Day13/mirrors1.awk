BEGIN { FS = ""; blockNo = 1 }

/^$/ { 
	blockNo++ 
	rowNo = 0
 }

/^(.|#)+$/ {
	rowNo++
	for (c = 1; c <= NF; c++) {
		blocks[blockNo]["rows"][rowNo][c] = $c
		blocks[blockNo]["cols"][c][rowNo] = $c
	}
}


END {
	for (b in blocks) {
		for (r in blocks[b]["rows"]) {
			for (c in blocks[b]["rows"][r]) {
				printf("%s", blocks[b]["rows"][r][c])
			}
			print ": " r
		}
		for (c in blocks[b]["cols"]) {
			for (c in blocks[b]["cols"][r]) {
				printf("%s", blocks[b]["cols"][r][c])
			}
			print ": " c
		}
		print b "----"
	}
}
	

/^.*$/ {
	for (i = 1; i <= 21; i++) {
		set[0 + NR][i] = $i
	}
	max = NF
}

END {
	total = 0 
	for (r in set) { 
		delete diff 
		delete maxDiff
		x = 1 

		for (i = 1; i < max; i++) { 
			diff[x][i] = set[r][i + 1] - set[r][i]
			maxDiff[x] = i
		}
		for (i = 1; i <= (max - 1); i++) { 
			if (diff[x][i] != 0) {
				t = 1
				break;
			}
		} 

		while (t != 0) {
			x++
			for (i = 1; i < maxDiff[x-1]; i++) {
				diff[x][i] = diff[x-1][i+1] - diff[x-1][i]
				maxDiff[x] = i
			}
		
			t = 0
			for (i = 1; i <= maxDiff[x]; i++) {
				if (diff[x][i] != 0) {
					t = 1
					break;
				}
			} 
		} 

	 	for (y = x; y > 1; y--) {
			diff[y-1][0] = diff[y-1][1] - diff[y][0]
		}
			
		set[r][0] = set[r][1] - diff[1][0]  

		print "------"
		for (z = 0; z <= max; z++) {
			printf("%s ", set[r][z])
		}
		print ": " set[r][0]

		for (a in diff) {
			for (b = 0; b <= maxDiff[a]; b++) {
				printf("%s ", diff[a][b])
			}
			print ": " diff[a][0]
		}
		print "     "

		total += set[r][0]
	}

	print "Total = " total
}


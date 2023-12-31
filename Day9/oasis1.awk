/^.*$/ {
	for (i = 1; i <= 21; i++) {
		set[0 + NR][i] = $i
	}
	set[0 + NR][0] = NF
	max = NF
}

END {
	total = 0 
	for (r in set) { 
		delete diff 
		x = 1 

		for (i = 1; i < max; i++) { 
			diff[x][i] = set[r][i + 1] - set[r][i]
			diff[x][0] = i
		}
		for (i = 1; i <= (max - 1); i++) { 
			if (diff[x][i] != 0) {
				t = 1
				break;
			}
		} 

		while (t != 0) {
			x++
			for (i = 1; i < diff[x-1][0]; i++) {
				diff[x][i] = diff[x-1][i+1] - diff[x-1][i]
				diff[x][0] = i
			}
		
			t = 0
			for (i = 1; i <= diff[x][0]; i++) {
				if (diff[x][i] != 0) {
					t = 1
					break;
				}
			} 
		} 

	 	for (y = x - 1; y > 0; y--) {
			diff[y][diff[y][0]+1] = diff[y][diff[y][0]] + diff[y+1][diff[y+1][0]+1]
		}
				
		set[r][max + 1] = set[r][max] + diff[1][diff[1][0]+1]  

		print "------"
		for (z = 1; z <= max + 1; z++) {
			printf("%s ", set[r][z])
		}
		print ": " set[r][0] + 1

		for (a in diff) {
			for (b = 1; b <= diff[a][0] + 1; b++) {
				printf("%s ", diff[a][b])
			}
			print ": " diff[a][0] + 1
		}
		print "     "

		total += set[r][max + 1]
	}

	print "Total = " total
}


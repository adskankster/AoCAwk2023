function itemToList(item, list) {
	
	subscr = 1
	delete list

	for (i = 2; i <= length(item); i++) {

		c = substr(item, i, 1)

		switch (c) {
			case "[":
				subscr = (subscr "," "1") 
			break
			
			case "]":
				
				d1 = "1"
				ci = lastIndexOf(subscr, ",")
				if (ci > 0) {
					d1 = substr(subscr, ci+1)
				}
				
				if (length(list[subscr]) == 0) { 
					if (d1 == 1) {
						list[subscr] = ""
					} else {
						delete list[subscr]
					}
				}
				
				if (ci > 0) {
					subscr = substr(subscr, 1, ci - 1)
				}
			break
			
			case ",": 
				ci = lastIndexOf(subscr, ",")
				if (ci > 0) {
					d2 = substr(subscr, ci+1)
					subscr = substr(subscr, 1, ci - 1)
					d2 = strtonum(d2) + 1
					subscr = subscr = (subscr "," d2) 
				} else {
					subscr = strtonum(subscr) + 1
				}
			break
				
			default:
				list[subscr] = c
			break
		}
	}
}

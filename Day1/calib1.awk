BEGIN { FPAT = "[[:digit:]]{1}"; total = 0 }
/^.+$/ {
	total += ($1 $NF)
}

END { print "total = " total }

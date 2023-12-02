
function lastIndexOf(str, find) {
	for (_i = length(str); _i > 0; _i--) {
		tmp = substr(str, _i, length(find))
		if (tmp == find) return _i
	}
	return 0
}

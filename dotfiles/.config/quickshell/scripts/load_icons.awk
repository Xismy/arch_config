BEGIN {
	current_file = ""
	read = 0
}

function print_entry() {
	print current_file ":" icon
	print class ":" icon
	current_file = FILENAME
	icon=""
	class""
	read = 1
}

END {
	print_entry()
}

/^\[Desktop Entry\]/ {
	print_entry()
	next;
}

/^\[/ {
	read = 0;
}

/^Icon=/ {
	if(read == 0) next;
	split($0, a, "=")
	icon = a[2]
}

/^StartupWMClass/ {
	if(read == 0) next;
	split($0, a, "=")
	class=a[2]
}

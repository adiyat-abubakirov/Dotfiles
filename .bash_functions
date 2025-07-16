# Custom Bash Functions
dm() {
	udisksctl mount -b /dev/$1
}

du() {
	udisksctl unmount -b /dev/$1
	udisksctl power-off -b /dev/$1
}

ssd-read-speed(){
   sudo hdparm -Tt /dev/$1
}

put() {
	echo "$1" | tee "$2" >/dev/null || sudo echo "$1" | sudo tee "$2" >/dev/null
}

append() {
	echo "$1" | tee -a "$2" >/dev/null || sudo echo "$1" | sudo tee -a "$2" >/dev/null
}

resize() {
	convert "$1" -resize "$2"^ -gravity center -extent "$2" "$3"
}

check256sum() {
	if [[ "$1" == "$(sha256sum "$2" | awk '{print $1;}')" ]]; then
		echo "OK"
	else
		echo "FAILED"
	fi
}

check1sum() {
	if [[ "$1" == "$(sha1sum "$2" | awk '{print $1;}')" ]]; then
		echo "OK"
	else
		echo "FAILED"
	fi
}

check224sum() {
	if [[ "$1" == "$(sha224sum "$2" | awk '{print $1;}')" ]]; then
		echo "OK"
	else
		echo "FAILED"
	fi
}

check384sum() {
	if [[ "$1" == "$(sha384sum "$2" | awk '{print $1;}')" ]]; then
		echo "OK"
	else
		echo "FAILED"
	fi
}

check512sum() {
	if [[ "$1" == "$(sha512sum "$2" | awk '{print $1;}')" ]]; then
		echo "OK"
	else
		echo "FAILED"
	fi
}

fnameex() {
	if [ -n "$1" ]; then
		find / -name "$1" 2>/dev/null | fzf
	else
		printf "Error: missing argument\n" >&2
      return 1
	fi
}

fpathex() {
	if [ -n "$1" ]; then
		find / -path "$1" 2>/dev/null | fzf
	else
		printf "Error: missing argument\n" >&2
      return 1
	fi
}

fname() {
	if [ -n "$1" ]; then
		find / -name "*$1*" 2>/dev/null | fzf
	else
		printf "Error: missing argument\n" >&2
      return 1
	fi
}

fpath() {
	if [ -n "$1" ]; then
		find / -path "*$1*" 2>/dev/null | fzf
	else
		printf "Error: missing argument\n" >&2
      return 1
	fi
}

# Credit: Chris Titus Tech
apt() {
	command nala "$@"
}

# Credit: Chris Titus Tech
sudo() {
	if [ "$1" = "apt" ]; then
		shift
		command sudo nala "$@"
	elif [ "$1" = "mkdir" ]; then
		shift
		command sudo mkdir -p "$@"
	elif [ "$1" = "cp" ]; then
		shift
		command sudo cp -ir "$@"
	elif [ "$1" = "mv" ]; then
		shift
		command sudo mv -i "$@"
	elif [ "$1" = "less" ]; then
		shift
		command sudo less -R "$@"
	else
		command sudo "$@"
	fi
}

#! /bin/bash

up() {
	amixer set 'Master' 5%+
	get
}
down() {
	amixer set 'Master' 5%-
	get
}
toggleMute() {
	read -r -a array <<<"$(amixer get 'Master' | tail -n 1)"
	if [ "${array[5]}" == "[off]" ]; then
		amixer set 'Master' unmute
	else
		amixer set 'Master' mute
	fi
	get
}
get() {
	read -r -a array <<<"$(amixer get 'Master' | tail -n 1)"
	if [ "${array[5]}" == "[off]" ]; then
		status=""
	else
		status=""
	fi
	dunstify -u low --replace=69 -t 1000 "$status  ${array[4]:1:-1}"
}
eval $1

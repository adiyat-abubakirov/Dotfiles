#!/bin/bash

caps_lock_status=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')
output="$(setxkbmap -query | awk -F : 'NR==3{print $2}' | sed 's/ //g')"

if [ "$caps_lock_status" = "on" ]; then
	output="$output!"
fi

echo $output

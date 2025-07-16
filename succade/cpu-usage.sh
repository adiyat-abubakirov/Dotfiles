#! /bin/bash

usage=$($HOME/.local/bin/cpu-proc -p 2)
if [[ ${usage%.*} -lt 25 ]]; then
	echo "%{F#fbf1c7}$usage"
elif [[ ${usage%.*} -lt 50 ]]; then
	echo "%{F#fabd2f}$usage"
else
	echo "%{F#fe8019}$usage"
fi

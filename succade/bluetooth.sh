#!/bin/bash

if [[ $(bluetoothctl show | grep "Powered: yes") ]]; then
	output="%{F#458588}"
	if [[ $(bluetoothctl devices Connected) ]]; then
    read -r -a array <<<"$(bluetoothctl info | tail -n 1)"
		output="$output %{F#fbf1c7}${array[3]:1:-1}%"
	fi
	echo "$output"
else
	echo ""
fi

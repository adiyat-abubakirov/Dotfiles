#!/bin/bash

hp_mac="B0:38:E2:54:BE:04" # headphones' mac address

# turns off bluetooth if turned on
if [[ $(bluetoothctl show | grep "Powered: yes") ]]; then
	bluetoothctl discoverable off
	bluetoothctl pairing off
	bluetoothctl scan off
	if [[ $(bluetoothctl power off | grep "succeeded") ]]; then
		dunstify -u low --replace=70 -t 1000 "Bluetooth powered off"
	else
		dunstify -u critical --replace=70 "Bluetooth FAILED to power off"
	fi

# turns on bluetooth & connects to headphones if turned off & headphones are paired
elif [[ $(bluetoothctl devices Paired | grep "$hp_mac") ]]; then
	if [[ $(bluetoothctl power on | grep "succeeded") ]]; then
		output="Bluetooth powered on"
      sleep 1s # give a second to bluetoothctl to turn on before sending connect signal
		connection="$(bluetoothctl connect "${hp_mac}" | grep "success")"
		if [[ $connection ]]; then
			output="${output}; Headphones connected successfully"
			dunstify -u low --replace=70 -t 1000 "$output"
		else
			output="${output}; Headphones are FAILED connected"
			dunstify -u critical --replace=70 "$output"
		fi
	else
		dunstify -u critical --replace=70 "Bluetooth FAILED to power on"
	fi
	bluetoothctl discoverable off
	bluetoothctl pairing off
	bluetoothctl scan off

# starts to automatically pair headphones if turned off & headphones are not paired
else
	bluetoothctl power on
	bluetoothctl discoverable on
	bluetoothctl pairable on
	bluetoothctl scan on &
	dunstify -u low --replace=70 -t 1000 "Starting pairing Headphones"
	while [[ true ]]; do
		if [[ $(bluetoothctl devices | grep "$hp_mac") ]]; then
			bluetoothctl trust $hp_mac && bluetoothctl pair $hp_mac && bluetoothctl connect $hp_mac
			bluetoothctl discoverable off && bluetoothctl pairable off && killall bluetoothctl
			dunstify -u low --replace=70 -t 1000 "Headphones has been paired successfully"
			break
		fi
		sleep 1
	done
fi

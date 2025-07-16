#!/bin/bash
#
# Source: http://github.com/mitchweaver/bin
# modernized it, so that it now changes color of foreground to take attention on temps
#

if [[ -z "$1" ]]; then
	if [[ $c -lt 50 ]]; then
		set -- '%{F#fbf1c7}$c°C'
	elif [[ $c -lt 70 ]]; then
		set -- '%{F#fabd2f}$c°C'
	elif [[ $c -lt 90 ]]; then
		set -- '%{F#fe8019}$c°C'
	else
		set -- '%{F#fb4934}$c°C'
	fi
fi

c=

case $(uname -s) in
OpenBSD*)
	c=$(sysctl -n hw.sensors.cpu0.temp0)
	c="${c%.*}"
	;;
Linux*)
	path=/sys/class/thermal/thermal_zone0/temp
	if [ -f $path ]; then
		read -r c <$path
	else
		echo "could not get temperature" >&2
		exit 1
	fi

	c="${c%???}"
	;;
*)
	echo "unsupported os: $(uname -s)" >&2
	exit 1
	;;
esac

eval echo "$1"

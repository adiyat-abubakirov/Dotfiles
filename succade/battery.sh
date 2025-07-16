#! /bin/bash

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery=
if [[ "$(cat /sys/class/power_supply/BAT0/status)" != "Discharging" ]]; then
	battery="%{F#b8bb26}"
elif [[ $capacity -lt 20 ]]; then
	dunstify -u critical --replace=71 "Battery is below 20%!!!"
fi
if [[ $capacity -lt 20 ]]; then
	battery="%{F#cc241d}$battery %{F#fb4934}$capacity"
elif [[ $capacity -lt 40 ]]; then
	battery="%{F#d65d0e}$battery %{F#fe8019}$capacity"
elif [[ $capacity -lt 60 ]]; then
	battery="%{F#d79921}$battery %{F#fabd2f}$capacity"
elif [[ $capacity -lt 80 ]]; then
	battery="%{F#689d6a}$battery %{F#fbf1c7}$capacity"
else
  battery="%{F#689d6a}$battery %{F#fbf1c7}$capacity"
fi
echo $battery

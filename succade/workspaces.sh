#! /bin/bash

workspaces=" "
for ((i = 1; i <= ${DESKTOPS##* }; i++)); do
	if [ $(bspc query -D -d "$i".focused) ]; then
		workspaces="${workspaces} %{+u} %{F#fbf1c7}$i %{-u}"
	elif [ $(bspc query -D -d "$i".occupied) ]; then
		workspaces="${workspaces}  %{F#ebdbb2}$i "
	else
		workspaces="${workspaces}  %{F#7c6f64}$i "
	fi
done
echo "$workspaces"

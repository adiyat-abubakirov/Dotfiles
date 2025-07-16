#!/bin/bash
# Spawn a new instance of Kitty using the CWD of the currently focused
# Kitty process.
#
# This is useful in environment like i3 where terminals are opened using a
# key-combination while another terminal is already focused.
#
# If the script is run with a non-Kitty window in focus or a non-compliant
# version of Kitty, an instance will be spawned in the user's $HOME.
#
active_window_info=$(xprop -id "$(bspc query -N -n .focused)")
active_wm_class=$(echo "$active_window_info" | grep WM_CLASS)
if [[ $active_wm_class == *"kitty"* ]]; then
	# Get PID. If _NET_WM_PID isn't set, bail.
	pid=$(echo "$active_window_info" | grep _NET_WM_PID | grep -oP "\d+")
	if [[ "$pid" == "" ]]; then
		kitty $@ &
	fi
	# Get first child of terminal
	child_pid=$(pgrep -P $pid | tail -n 1)
	if [[ "$child_pid" == "" ]]; then
		kitty $@ &
	fi
	# Get current directory of child. the first child should be the shell
	shell_cwd=$(readlink /proc/${child_pid}/cwd)
	# Start Kitty with the working directory
	kitty --working-directory $shell_cwd $@ &
else
	kitty $@ &
fi

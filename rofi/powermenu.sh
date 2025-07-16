#! /bin/bash

choice=$(printf "lock\nshutdown\nreboot" | rofi -dmenu -normal-window -theme-str '@import "powermenu.rasi"')
case "$choice" in
lock) bash $HOME/.config/rofi/i3lock.sh ;;
shutdown) systemctl poweroff ;;
reboot) systemctl reboot ;;
esac

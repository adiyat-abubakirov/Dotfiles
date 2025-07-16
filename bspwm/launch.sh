#! /bin/bash
# shellcheck disable=2086
# sets preferences for monitors, apps & xsession here

setupExternalMonitor() { # set apps dimensions for external monitor
	ln -sfT $HOME/.config/kitty/kitty.conf.external $HOME/.config/kitty/kitty.conf
	ln -sfT $HOME/.config/succade/succaderc.external $HOME/.config/succade/succaderc
	ln -sfT $HOME/.config/dunst/dunstrc.external $HOME/.config/dunst/dunstrc
	ln -sfT $HOME/.config/sxhkd/sxhkdrc.external $HOME/.config/sxhkd/sxhkdrc
	ln -sfT $HOME/.config/rofi/config.rasi.external $HOME/.config/rofi/config.rasi
	ln -sfT $HOME/.config/rofi/powermenu.rasi.external $HOME/.config/rofi/powermenu.rasi
	ln -sfT $HOME/.config/obsidian/b74bf8887eced4a0.json.external $HOME/.config/obsidian/b74bf8887eced4a0.json
	ln -sfT $HOME/.config/gtk-3.0/settings.ini.external $HOME/.config/gtk-3.0/settings.ini
	ln -sfT $HOME/.mozilla/firefox/0kd4sopq.default/user.js.external $HOME/.mozilla/firefox/0kd4sopq.default/user.js
}
setupBuiltInMonitor() { # set apps dimensions for builtin monitor
	ln -sfT $HOME/.config/kitty/kitty.conf.builtin $HOME/.config/kitty/kitty.conf
	ln -sfT $HOME/.config/succade/succaderc.builtin $HOME/.config/succade/succaderc
	ln -sfT $HOME/.config/dunst/dunstrc.builtin $HOME/.config/dunst/dunstrc
	ln -sfT $HOME/.config/sxhkd/sxhkdrc.builtin $HOME/.config/sxhkd/sxhkdrc
	ln -sfT $HOME/.config/rofi/config.rasi.builtin $HOME/.config/rofi/config.rasi
	ln -sfT $HOME/.config/rofi/powermenu.rasi.builtin $HOME/.config/rofi/powermenu.rasi
	ln -sfT $HOME/.config/obsidian/b74bf8887eced4a0.json.builtin $HOME/.config/obsidian/b74bf8887eced4a0.json
	ln -sfT $HOME/.config/gtk-3.0/settings.ini.builtin $HOME/.config/gtk-3.0/settings.ini
	ln -sfT $HOME/.mozilla/firefox/0kd4sopq.default/user.js.builtin $HOME/.mozilla/firefox/0kd4sopq.default/user.js
}
setup() {
	xrandr --output "$1" --primary --mode "$2" -r "$3" --brightness 1 --pos 0x0 --rotate normal # setup main monitor
	if [[ "$6" == "1" ]]; then
		redshift -m randr -O 5500 -P # make built-in screen warm like external
	fi
	bspc monitor -g "$2"+0+0  # set monitor dimensions in bspwm
	bspc monitor -d $DESKTOPS # set virtual desktops
	eval "$4"
	echo "Xcursor.size: $5" | xrdb # set cursor size in xsession
}

if [[ $(envycontrol --query) == "integrated" ]]; then
	setup "eDP" "2880x1800" "120" "setupBuiltInMonitor" "50" "1"
elif [[ $(xrandr | grep "DP-1 connected") ]]; then
	setup "DP-1" "1920x1080" "100" "setupExternalMonitor" "1" "0"  #"output" "eDP-1-0" "output" "HDMI-0"
elif [[ $(xrandr | grep "HDMI-0 connected") ]]; then            # display other than my own
	setup "HDMI-0" "3840x2160" "60" "setupBuiltInMonitor" "50" "0" #"output" "eDP-1-0" "output" "DP-1"
else
	setup "eDP-1-0" "2880x1800" "120" "setupBuiltInMonitor" "50" "1" #"output" "DP-1" "output" "HDMI-0"
fi

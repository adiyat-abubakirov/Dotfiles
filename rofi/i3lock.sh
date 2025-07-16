#! /bin/bash

wrong=fb4934
bg=1d2021

setxkbmap "us" # setting us keyboard layout

# i3lock color is used, fork of i3lock
i3lock -c $bg -f -e --inside-color=$bg --ring-color=$bg --insidever-color=$bg --ringver-color=$bg --insidewrong-color=$bg --ringwrong-color=$bg --line-uses-inside --keyhl-color=$bg --separator-color=$bg --bshl-color=$bg --wrong-text="Access Denied" --wrong-font="JetBrainsMono Nerd Font" --wrong-color=$wrong --verif-color=$bg --lockfailed-text="Failed Acquire K&M Access"

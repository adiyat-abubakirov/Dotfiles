#!/bin/bash
current_layout=$(setxkbmap -query | awk -F : 'NR==3{print $2}' | sed 's/ //g')

if [ "$current_layout" = "us" ]; then
    setxkbmap "ru"
else
    setxkbmap "us"
fi

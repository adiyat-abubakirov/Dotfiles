#!/bin/bash

# global xinitrc file path = /etc/X11/xinit/xinitrc
# invoke global X session script
. /etc/X11/Xsession

exec bspwm

#! /bin/bash

echo "%{F#fbf1c7}$(nmcli | grep "wlp4s0: connected" | cut -b 22-)"

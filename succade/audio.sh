#! /bin/bash

IFS=', ' read -r -a array <<<"$(amixer get 'Master' | grep 'Front Left:' | tr -d '[]')"
if [ "${array[5]}" == "off" ]; then
	status=""
else
	status=""
fi
echo "%{F#fe8019}$status %{F#fbf1c7}${array[4]:0:-1}"

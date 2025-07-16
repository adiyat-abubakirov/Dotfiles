# shellcheck disable=2148

# gpu
alias g-status='envycontrol --query'
alias g-amdreboot='sudo envycontrol -s integrated && systemctl reboot'
alias g-nvidiareboot='sudo envycontrol -s nvidia && systemctl reboot'
alias g-amdshutdown='sudo envycontrol -s integrated && systemctl poweroff'
alias g-nvidiashutdown='sudo envycontrol -s nvidia && systemctl poweroff'
alias oglprovider='glxinfo | grep OpenGL'

# cpu & fetch
alias neofetch='fastfetch'
alias allfetch='fastfetch -c $HOME/.config/fastfetch/all.jsonc'
alias c-ultrasaving='sudo cpupower frequency-set -g powersave -d 0.001G -u 0.6G && sudo echo -n 80 | sudo tee /sys/class/backlight/amdgpu_bl0/brightness && echo "/255 - brightness"'
alias c-saving='sudo cpupower frequency-set -g ondemand -d 0.001G -u 1.5G && sudo echo -n 127 | sudo tee /sys/class/backlight/amdgpu_bl0/brightness && echo "/255 - brightness"'
alias c-powersupply='sudo cpupower frequency-set -g ondemand -d 0.001G -u 3.8G && sudo echo -n 153 | sudo tee /sys/class/backlight/amdgpu_bl0/brightness && echo "/255 - brightness"'
alias c-frequency='cpufreq-info | grep "current CPU" | cut -b 28-'

# Credit: Chris Titus Tech
# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias pd='cd "$OLDPWD"'

# custom ls
alias lal='ls -Alh'                                  # show long list of hidden files
alias la='ls -Ah'                                    # list of Hidden Files
alias ll='ls -lh'                                    # Long List
alias lk='ls -lASrh'                                 # long sort by size
alias lc='ls -lAtcrh'                                # long sort by time when it was changed
alias lu='ls -lAturh'                                # long sort by time when it was used
alias lm='ls -lAtrh'                                 # long sort by time when it was created
alias labc='ls -lAph'                                # long alphabetical sort
alias lfi="ls -lAh | grep -v 'total' | grep -v '^d'" # long list of files only
alias ldir="ls -lAh | grep -v 'total' | grep '^d'"   # long list of directories only
alias ls='ls -h --color=always'

# enabling colors
alias dir='dir --color=always'
alias vdir='vdir --color=always'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'

# nala
alias n-hist='nala history'
alias n-fetch='sudo nala fetch'
alias n-undo='sudo nala history undo'
alias n-installbackports='sudo nala install -o APT::Default-Release="bookworm-backports"'
alias n-update='sudo nala update && sudo nala upgrade'
alias n-clean='sudo nala autopurge && sudo nala clean'

# trash-put
alias tp='trash-put'
alias thist='trash-list | tr "\n" "\0" | sort -z | tr "\0" "\n"'
alias trs='trash-restore'

# Credit: Chris Titus Tech
# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='dunstify --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# other
alias lf=". $HOME/.config/lf/lf-kitty"
alias dl='lsblk'
alias mkdir='mkdir -p'
alias cp='cp -ir'
alias diff='diff -q'
alias mv='mv -i'
alias ps='ps auxf'
alias less='less -R'
alias vi='$EDITOR'
alias svi='sudo -Es $EDITOR'
alias bhist='history | less'
alias et='unp -U'
alias gearlever='flatpak run it.mijorus.gearlever'
alias feh='feh -.'

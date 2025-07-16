# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

export PATH=$PATH:$HOME/.local/bin:$HOME/.fzf/bin:$HOME/.local/kitty.app/bin:$HOME/.local/zig-linux-x86_64-*/zig:$HOME/.local/cmake-4.0.2-linux-x86_64/bin:$HOME/.local/android-studio/bin

# fzf
export FZF_DEFAULT_OPTS="--color='bg:#1d2021,bg+:#282828,info:#fabd2f,border:#504945,spinner:#8ec07c'
--color='hl:#689d6a,fg:#bdae93,header:#689d6a,fg+:#ebdbb2'
--color='pointer:#b8bb26,marker:#b8bb26,prompt:#b8bb26,hl+:#b8bb26' --border='sharp' --border-label='' --preview-window='border-sharp' --prompt='> '
  --marker='*' --pointer='>' --separator='─' --scrollbar='█'"
export FZF_ALT_C_OPTS="--preview 'ls -Alh --color=always {} | head -200'"
export FZF_CTRL_T_OPTS="--preview '(cat {} || ls -Alh --color=always {}) 2> /dev/null | head -200'"

# android studio TMP
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export REPO_OS_OVERRIDE=linux

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export TERM=xterm-kitty
export HOME=/home/adiyat
export DESKTOPS='1 2 3 4 5 6 7 8 9 10'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Expand the history size
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%F %T " # add timestamp to history
export EDITOR='nvim -u $HOME/.config/nvim/init.lua'

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize // WARN:

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# disable stupid mails in /var/mail/
export MAILCHECK=-1

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# setting default prompt (default prompt, but without if/case checkers)
PS1='\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# True Color support
export COLORTERM=truecolor

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Custom Bash Functions
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

eval "$(oh-my-posh init bash --config $HOME/.config/oh-my-posh.omp.json)"

eval "$(fzf --bash)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

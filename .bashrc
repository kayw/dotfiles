# Check for an interactive session
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

export PATH={$PATH}:/usr/local/bin/:/home/kayw/bin/:/usr/local/texlive/2010/bin/i386-linux/:/usr/local/bin/depot_tools/
export LD_LIBRARY_PATH={LD_LIBRARY_PATH}:/usr/local/lib/

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto -A'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dotfiles='git --git-dir=/home/kayw/.git --work-tree=/home/kayw'

#export PS1="\[\e[36;1m\]\u\[\e[34;1m\]@\[\e[32;1m\]\H\[\e[30;1m\](\j)\[\e[33;1m\]\W\[\033k\033\134\] \$ \[\e[0m\]"
export PS1="\[\e[33;1m\]\u\[\e[34;1m\]@\[\e[32;1m\]\H\[\e[30;1m\]\[\e[36;1m\] \W\[\033k\033\134\] \$ \[\e[0m\]\[\e[1;32m\]"
# export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
# root
if [[ $UID == 0 ]]; then
PS1='\[\e[0;31m\]\u \[\e[1;34m\]\w \[\e[0;31m\]\$ \[\e[0;32m\]'
fi

case $TERM in
xterm*|rxvt)
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
;;
#screen*)
#PROMPT_COMMAND='echo -ne "\033k\033\134\033k${HOSTNAME}[`basename ${PWD}`]\033\134"'
esac

# PS1='[\u@\h \W]\$ '

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# man:
function man
{
	/usr/bin/man $* | col -b | /usr/local/bin/vim -c 'set ft=man nomod nolist' -
}

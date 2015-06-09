# Check for an interactive session
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups:ignoreboth
# http://mewbies.com/how_to_disable_bash_history_or_limit_tutorial.html
export HISTIGNORE='&:[ ]*:ls*:cd*:ps*:du*:rm*:cat*'
# ... or force ignoredups and ignorespace
#export HISTCONTROL=ignoreboth

export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/usr/local/lib/
#export PYTHONPATH=$PYTHONPATH:/home/kayw/share/codebase/hyde/kayw.github.com/extensions/

#http://stackoverflow.com/questions/25433505/go-all-bash-compilation-testing-fails-with-permission-denied
export GOROOT=/home/kayw/share/codebase/vm/go
export GOPATH=$GOROOT/gows
export PATH=$PATH:/home/kayw/bin/:/usr/local/texlive/2010/bin/i386-linux/:$GOROOT/bin:$GOPATH/bin
#http://stackoverflow.com/questions/13830594/when-i-execute-bash-the-path-keeps-repeating-itself
#export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: '!(a[$0]++)' | sed 's/:$//')

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
#$ export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[1;$((31+3*!$?))m\]\$\[\033[00m\] '

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
#git alias
if [ -f $HOME/bin/git-completion.bash ]; then
    . $HOME/bin/git-completion.bash
fi
#complete -o bashdefault -o default -o nospace -F _gitk co
#http://benmabey.com/2008/05/07/git-bash-completion-git-aliases.html
# man:
function man
{
	/usr/bin/man $* | col -b | /usr/local/bin/vim -c 'set ft=man nomod nolist' -
}

#https://bbs.archlinux.org/viewtopic.php?id=92286
# start screen (wheee!!)
#if [ $TERM != "screen-256color" ] ; then
#	   screen -d -R
#   fi

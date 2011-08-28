if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
startx
logout
fi

. $HOME/.bashrc

# start screen (wheee!!)
# put here because .bash_profile read only once
# http://www.opensubscriber.com/message/screen-users@gnu.org/4932849.html
# autostart gnu screen whenever a new terminal session is initiated
# if there's a session available then reattach, else start a new GNU Screen session 
#if [ -z "$STY" ] ; then
#	exec screen -dR
#fi
alias dotfiles='git --git-dir=/home/kayw/.git --work-tree=/home/kayw'

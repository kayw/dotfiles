# Check for an interactive session
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups:ignoreboth
# http://mewbies.com/how_to_disable_bash_history_or_limit_tutorial.html
export HISTIGNORE='&:[ ]*:ls*:cd*:ps*:du*:rm*:cat*'
# ... or force ignoredups and ignorespace
#export HISTCONTROL=ignoreboth

export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/usr/local/lib/  #rustlib node_modules
#export PYTHONPATH=$PYTHONPATH:/home/kayw/share/codebase/hyde/kayw.github.com/extensions/

export GEM_HOME=$HOME/fshare/.gem
export GEM_PATH=/usr/lib/ruby/gems/2.2.0
export GEM_SPEC_CACHE=$GEM_HOME/specs
export GRADLE_USER_HOME=$HOME/fshare/.gradle
export ANDROID_SDK_HOME=$HOME/fshare/.android

#http://stackoverflow.com/questions/25433505/go-all-bash-compilation-testing-fails-with-permission-denied
export GOROOT=$HOME/kspace/goroot
export GOPATH=$HOME/kspace/go
export PATH=$PATH:/home/kayw/bin/:$GOROOT/bin:$GOPATH/bin:/opt/webstorm/bin:$GEM_HOME/bin:/opt/apache-maven-3.3.3/bin:$HOME/.config/AndroidStudio/sdk/platform-tools
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
alias mvn='ANDROID_HOME=$HOME/.config/AndroidStudio/sdk mvn -gs "/home/kayw/fshare/.m2/global/settings.xml"'
alias studio='ANDROID_SDK_HOME=$HOME/fshare/ /usr/local/android-studio/bin/studio.sh'

# PS1='[\u@\h \W]\$ '
# export PS1="\[\e[36;1m\]\u\[\e[34;1m\]@\[\e[32;1m\]\H\[\e[30;1m\](\j)\[\e[33;1m\]\W\[\033k\033\134\] \$ \[\e[0m\]" \134 is \
# export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]' \[\e[m\] ending color
# export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \[\033[1;$((31+3*!$?))m\]\$\[\033[00m\] '
# export PS1="\[\e[33;1m\]\u\[\e[34;1m\]@\[\e[32;1m\]\H\[\e[30;1m\]\[\e[36;1m\] \W\[\033k\033\134\] \$ \[\e[0m\]\[\e[1;32m\]"
export PS1="\[\e[33;1m\]\u\[\e[34;1m\]@\[\e[32;1m\]\H\[\e[30;1m\]\[\e[36;1m\] \W \$\[\e[0m\]\[\e[1;32m\]"
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
screen*)
PROMPT_COMMAND='echo -ne "\033]2;`perl -pl0 -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD}`\033\\"'
#http://unix.stackexchange.com/questions/26844/abbreviated-current-directory-in-shell-prompt
#http://vim.wikia.com/wiki/Automatically_set_screen_title
esac


#git alias
if [ -f $HOME/bin/git-completion.bash ]; then
    . $HOME/bin/git-completion.bash
fi
#complete -o bashdefault -o default -o nospace -F _gitk co
#http://benmabey.com/2008/05/07/git-bash-completion-git-aliases.html

# man:
function man
{
#http://vim.wikia.com/wiki/Using_vim_as_a_man-page_viewer_under_Unix
#http://stackoverflow.com/questions/16740246/what-is-a-way-to-read-man-pages-in-vim-without-using-temporary-files
#goog vim as man pager
Title=''
for i in $@; do
	Title+='-'$i
done

/usr/bin/man $* | col -b | vim -c 'file MAN'$Title -c 'set ft=man nomod nolist titlestring=MAN'$Title -c 'nmap K :Man <C-R>=expand("<cword>")<CR><CR>' -
}

### quinn dotfiles
#alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
#alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
#alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
#alias grep='grep --color=tty -d skip'
#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano PKGBUILD'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# necessary work settings per terminal session(!!!must put .profile or .bashrc, can't use in a separate script)
export NVM_DIR="$HOME/fshare/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # load nvm completion
command -v nvm &> /dev/null && nvm use iojs
#. "$HOME/.nvm/nvm.sh" && . "$HOME/.nvm/bash_completion" && nvm use iojs;

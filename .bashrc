# Check for an interactive session
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups:ignoreboth
# http://mewbies.com/how_to_disable_bash_history_or_limit_tutorial.html
export HISTIGNORE='&:[ ]*:ls*:cd*:ps*:du*:rm*:cat*'
# ... or force ignoredups and ignorespace
#export HISTCONTROL=ignoreboth

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/  #rustlib node_modules
#export PYTHONPATH=$PYTHONPATH:/home/kayw/share/codebase/hyde/kayw.github.com/extensions/

export GEM_HOME=$HOME/fshare/.gem
export GEM_PATH=/usr/lib/ruby/gems/2.3.0
export GEM_SPEC_CACHE=$GEM_HOME/specs
export GRADLE_USER_HOME=$HOME/fshare/.gradle
export ANDROID_SDK_HOME=$HOME/fshare/.android/sdk
export ANDROID_SDK_ROOT=$HOME/fshare/.android/sdk
export PM2_HOME=$HOME/fshare/.pm2/
export BABEL_CACHE_PATH=/tmp/babel.json
export NODE_REPL_HISTORY=$HOME/fshare/.node_history
export PYTHONSTARTUP=$HOME/fshare/.py_history
export PYTHONUSERBASE=$HOME/fshare/.pip
export npm_config_devdir=/home/kayw/fshare/.npm/.node_gyp #https://github.com/nodejs/node-gyp/issues/21
export ELECTRON_MIRROR="https://npm.taobao.org/mirrors/electron/"
export ELECTRON_CACHE=/home/kayw/fshare/.npm/electron/
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export GOPROXY=https://mirrors.aliyun.com/goproxy/

#http://stackoverflow.com/questions/25433505/go-all-bash-compilation-testing-fails-with-permission-denied
#export GOROOT=$HOME/kspace/goroot
export GOPATH=$HOME/kspace/go
export PATH=$PATH:/home/kayw/bin/:$GOPATH/bin:$GEM_HOME/bin:$HOME/fshare/.pip/bin:$ANDROID_SDK_HOME/platform-tools:$ANDROID_SDK_HOME/emulator:$ANDROID_SDK_HOME/tools:/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin/:/opt/flutter/.pub-cache/bin
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
# http://stackoverflow.com/questions/3455625/linux-command-to-print-directory-structure-in-the-form-of-a-tree
alias lst='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e \
          '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias lss='find . -type f | grep -v ".git" | xargs du -b | sort -rn' #http://unix.stackexchange.com/questions/53737/how-to-list-all-files-in-the-size-order
alias getack='curl -L http://betterthangrep.com/ack-standalone > ~/bin/ack'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias dotfiles='git --git-dir=/home/kayw/.git --work-tree=/home/kayw'
alias mvn='ANDROID_HOME=$HOME/fshare/.android/sdk /opt/apache-maven-3.3.3/bin/mvn -gs "/home/kayw/fshare/.m2/global/settings.xml"'
alias studio='ANDROID_SDK_HOME=$HOME/fshare/.android/sdk/ /usr/local/android-studio/bin/studio.sh >/dev/null 2>&1'
alias wps='wps -style gtk+'

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
PROMPT_COMMAND='echo -ne "\033]2;`perl -pl0 -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD} | tr -d "\000"`\033\\"'
#PROMPT_COMMAND='echo -ne "\033]2;`sed "s|^${HOME}|~|;s:\([^/]\)[^/]*/:\1/:g" <<<$PWD`\033\\"'
#http://unix.stackexchange.com/questions/26844/abbreviated-current-directory-in-shell-prompt  For vim bash prompt directory
#http://vim.wikia.com/wiki/Automatically_set_screen_title
#https://github.com/dracutdevs/dracut/pull/119/files
esac


#git alias
#if [ -f $HOME/bin/git-completion.bash ]; then  /usr/share/bash-completion/completions/git
#    . $HOME/bin/git-completion.bash
#fi
#complete -o bashdefault -o default -o nospace -F _gitk co
#http://benmabey.com/2008/05/07/git-bash-completion-git-aliases.html
alias kgit="GIT_DIR=~/kspace/dotfiles/.git GIT_WORK_TREE=~ git"

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

top10() {
  #from newsmth
  ps -e -o comm -o %mem= | sort -nrk2 | head -n 10

  #list most frequent used command http://talk.linuxtoy.org/using-cli/
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)\
  print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" \
  | column -c3 -s " " -t | sort -nr | nl | head -n10
}

alias work='. ~/bin/work'

# nvm settings per terminal session
#. "$HOME/.nvm/nvm.sh" && . "$HOME/.nvm/bash_completion" && nvm use iojs;(!!!this one need source Or . in script)
export NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node  # https://cnodejs.org/topic/5338c5db7cbade005
export NVM_DIR="$HOME/fshare/.nvm" # upgrade git fetch --tags origin git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # load nvm completion
command -v nvm &> /dev/null && nvm use default

command -v nodemon &> /dev/null || alias nodemon="pm2 start --no-daemon"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# mkdir -p ~/kspace/dotfiles  ~/kspace/env/npm  ~/kspace/env/nvm  should be owned by kayw
# git clone --bare git@github.com:kayw/dotfiles.git kspace/dotfiles/.git
# alias kgit...   kgit checkout
# git clone git@github.com:kayw/dwm.git kspace/dwm  make install
# install nvm node trojan-go  vim plug install
#
# NOTES:
# backup_rsync.timer backup_rsync.service  added into /etc/systemd/system/  systemd enable / start
# /mnt/pc005/var/lib/docker linked to /var/lib/docker

# Check for an interactive session
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}erasedups:ignoreboth
# http://mewbies.com/how_to_disable_bash_history_or_limit_tutorial.html
export HISTIGNORE='&:[ ]*:ls*:cd*:ps*:du*:rm*:cat*'
# https://linuxhint.com/bash_command_history_usage/
export HISTSIZE=100000
export HISTFILESIZE=100000
# ... or force ignoredups and ignorespace
#export HISTCONTROL=ignoreboth

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/  #rustlib node_modules

KSPACE_ENV=$HOME/kspace/env
export GEMRC=$HOME/.config/gemrc #https://docs.ruby-lang.org/en/2.5.0/Gem/ConfigFile.html  https://jordanelver.co.uk/blog/2020/12/06/project-specific-gemrc-files-using-the-gemrc-environment-variable/
export GEM_HOME=$KSPACE_ENV/gems
#export GEM_PATH=/usr/lib/ruby/gems/2.6.0
export GEM_SPEC_CACHE=$GEM_HOME/specs
export GRADLE_USER_HOME=$KSPACE_ENV/gradle
#export ANDROID_HOME=$KSPACE_ENV/.android  react-native use this for sdk
export ANDROID_SDK_HOME=$KSPACE_ENV/android
export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME/sdk
export ANDROID_EMULATOR_HOME=$ANDROID_SDK_HOME
export ANDROID_AVD_HOME=$ANDROID_SDK_HOME/avd
export STUDIO_PROPERTIES=$ANDROID_SDK_HOME/idea.properties
export PM2_HOME=$KSPACE_ENV/pm2/
export BABEL_CACHE_PATH=/tmp/babel.json
export NODE_REPL_HISTORY=$HOME/.cache/.node_history
export npm_config_userconfig=$HOME/.config/npmrc   #https://docs.npmjs.com/cli/v10/commands/npm#configuration
export ELECTRON_MIRROR="https://npmmirror.com/mirrors/electron/"
export ELECTRON_CACHE=$HOME/.cache/electron/
export PYTHONSTARTUP=$HOME/.config/python/pythonrc #https://unix.stackexchange.com/questions/630642/change-location-of-python-history
export PYTHONUSERBASE=$KSPACE_ENV/pip
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export PUB_CACHE=$KSPACE_ENV/flutter-pub
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export GOPROXY=https://goproxy.cn,direct
#http://stackoverflow.com/questions/25433505/go-all-bash-compilation-testing-fails-with-permission-denied
#export GOROOT=$HOME/kspace/goroot
export GOPATH=$KSPACE_ENV/go
export SQLITE_HISTORY=$HOME/.cache/sqlite_history  # https://unix.stackexchange.com/questions/306890/change-location-of-sqlite-history-file
export DOCKER_CONFIG=$HOME/.config/docker
#cat $(kpsewhich texmf.cnf) https://tex.stackexchange.com/questions/467824/is-it-possible-to-relocate-my-texmf-directory
export TEXMFHOME=$HOME/.config/texlive/texmf
export TEXMFVAR=$HOME/.config/texlive/texmf-var
export TEXMFCONFIG=$HOME/.config/texlive/texmf-config

export DOTNET_ROOT=/opt/dotnet
FLUTTER_ROOT=/opt/flutter

# https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash
if [[ $PATH != *"/home/kayw/bin/"* ]]; then
  export PATH=$PATH:$HOME/bin/:$GOPATH/bin:$GEM_HOME/bin:$PYTHONUSERBASE/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$FLUTTER_ROOT/bin:$FLUTTER_ROOT/bin/cache/dart-sdk/bin/:$FLUTTER_ROOT/.pub-cache/bin:$DOTNET_ROOT:$DOTNET_ROOT/tools
fi
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
alias studio='/opt/android-studio/bin/studio.sh >/dev/null 2>&1'

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
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node  # https://cnodejs.org/topic/5338c5db7cbade005
export NVM_DIR="$KSPACE_ENV/nvm" # upgrade git fetch --tags origin git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # load nvm completion
#[ -z "${TMUX}" ] && command -v nvm &> /dev/null && nvm use default

#command -v nodemon &> /dev/null || alias nodemon="pm2 start --no-daemon"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
command -v kubectl &> /dev/null && source <(kubectl completion bash)

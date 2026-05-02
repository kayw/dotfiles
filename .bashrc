# mkdir -p ~/.local/share/dotfiles  /var/log/dwm should be owned by kayw
# git clone --bare git@github.com:kayw/dotfiles.git .local/share/dotfiles/.git
# alias kgit...   kgit checkout
# git clone git@github.com:kayw/dwm.git .local/share/dwm  make install
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
export HISTIGNORE='&:[ ]*:ls*:cd*:ps*:du*:rm*:cat*:vim'
# https://linuxhint.com/bash_command_history_usage/

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000
export HISTFILESIZE=10000000

export XDG_CONFIG_HOME=$HOME/.config
KSPACE_ENV=$HOME/kspace/env
export GEMRC=$HOME/.config/gemrc #https://docs.ruby-lang.org/en/2.5.0/Gem/ConfigFile.html  https://jordanelver.co.uk/blog/2020/12/06/project-specific-gemrc-files-using-the-gemrc-environment-variable/
export GEM_HOME=$KSPACE_ENV/gems
export GEM_SPEC_CACHE=$GEM_HOME/specs
export GRADLE_USER_HOME=$KSPACE_ENV/gradle
#export ANDROID_HOME=$KSPACE_ENV/.android  react-native use this for sdk
export ANDROID_SDK_HOME=$KSPACE_ENV/android
export ANDROID_SDK_ROOT=$ANDROID_SDK_HOME/sdk
export ANDROID_EMULATOR_HOME=$ANDROID_SDK_HOME
export ANDROID_AVD_HOME=$ANDROID_SDK_HOME/avd
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
export KUBECONFIG=$HOME/.config/kubeconfig
export GNUPGHOME=$HOME/.local/share/gnupg
export KODI_DATA=$HOME/.local/share/kodi
export __GL_SHADER_DISK_CACHE_PATH=$HOME/.cache/nvidia
export RUSTUP_HOME=$HOME/.local/share/rustup
export CARGO_HOME=$HOME/.local/share/cargo

#export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto -A'
# http://stackoverflow.com/questions/3455625/linux-command-to-print-directory-structure-in-the-form-of-a-tree
alias lst='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e \
          '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias lss='find . -type f | grep -v ".git" | xargs du -b | sort -rn' #http://unix.stackexchange.com/questions/53737/how-to-list-all-files-in-the-size-order
alias grep='grep --color=auto'

alias kgit="GIT_DIR=~/kspace/dotfiles/.git GIT_WORK_TREE=~ git"
alias docker="podman"

export PS1="\[\e[33;1m\]\u\[\e[34;1m\]@\[\e[32;1m\]\H\[\e[30;1m\]\[\e[36;1m\] \W \$\[\e[0m\]\[\e[1;32m\]"
# root
if [[ $UID == 0 ]]; then
PS1='\[\e[0;31m\]\u \[\e[1;34m\]\w \[\e[0;31m\]\$ \[\e[0;32m\]'
fi

case $TERM in
xterm*|rxvt)
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
;;
screen*)
PROMPT_COMMAND='echo -ne "\033]2;`perl -pl0 -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD} | tr -d "\000"`\033\\"'
#PROMPT_COMMAND='echo -ne "\033k\033\134\033k${HOSTNAME}[`basename ${PWD}`]\033\134"'
#PROMPT_COMMAND='echo -ne "\033]2;`sed "s|^${HOME}|~|;s:\([^/]\)[^/]*/:\1/:g" <<<$PWD`\033\\"'
#http://unix.stackexchange.com/questions/26844/abbreviated-current-directory-in-shell-prompt  For vim bash prompt directory
#http://vim.wikia.com/wiki/Automatically_set_screen_title
#https://github.com/dracutdevs/dracut/pull/119/files
esac


function man
{
#http://vim.wikia.com/wiki/Using_vim_as_a_man-page_viewer_under_Unix
#http://stackoverflow.com/questions/16740246/what-is-a-way-to-read-man-pages-in-vim-without-using-temporary-files
#vim as man pager
Title=''
for i in $@; do
  Title+='-'$i
done

/usr/bin/man $* | col -b | vim -c 'file MAN'$Title -c 'set ft=man nomod nolist titlestring=MAN'$Title -c 'nmap K :Man <C-R>=expand("<cword>")<CR><CR>' -
}


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


# nvm settings per terminal session
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node  # https://cnodejs.org/topic/5338c5db7cbade005
export NVM_DIR="$KSPACE_ENV/nvm" # upgrade git fetch --tags origin git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # load nvm completion

[ -f $HOME/.config/fzf/fzf.bash ] && source $HOME/.config/fzf/fzf.bash  #https://github.com/junegunn/fzf/pull/1282
command -v kubectl &> /dev/null && source <(kubectl completion bash)

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.local/bin/env"

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]] then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
  exec fish $LOGIN_OPTION
fi

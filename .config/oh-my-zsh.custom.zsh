# Put files in this folder to add your own custom functionality.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Customization
#
# Files in the custom/ directory will be:
# - loaded automatically by the init script, in alphabetical order
# - loaded last, after all built-ins in the lib/ directory, to override them
# - ignored by git by default
#
# Example: add custom/shortcuts.zsh for shortcuts to your local projects
#
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

export PATH=/opt/homebrew/bin/:$PATH
setopt COMPLETE_ALIASES

#_kgit() {
#  ((CURRENT == 3)) &&
#  _files -/
#}
compdef kgit='git'

# https://superuser.com/questions/735660/whats-the-zsh-equivalent-of-bashs-prompt-command
# https://stackoverflow.com/questions/16624752/tmux-how-to-configure-tmux-to-display-the-current-working-directory-of-a-pane-o
precmd() {
  [[ -n "$TMUX" ]] && echo -ne "\033]2;`perl -pl0 -e "s|^${HOME}|~|;s|([^/])[^/]*/|$""1/|g" <<<${PWD} | tr -d "\000"`\033\\"
    # Restore original window name if it was changed
  #local current_name="$(tmux display-message -p '#W')"
  tmux rename-window ""
  tmux set-window-option allow-rename off
  #tmux set-window-option automatic-rename off
  #if [[ "$last_cmd" == *psql ]]; then
    #tmux rename-window "$ORIG_TMUX_WINDOW_NAME"
  #else
  #  ORIG_TMUX_WINDOW_NAME=$current_name
  #fi
}

alias kgit="GIT_DIR=~/dotfiles/.git GIT_WORK_TREE=~ git"
#zstyle ':completion:*:*:kgit:*' file-patterns '*:all-files'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#https://tcude.net/enabling-command-autocomplete-in-zsh/
#https://timjames.dev/blog/overhaul-your-terminal-with-zsh-plugins-more-3oag
#
#
#https://github.com/newelldev/macos-terminal-solarized


check_psql_host() {
  local cmd="$1"
  if [[ $cmd != *psql* ]]; then
    return
  fi
  local result

  result=$(echo "$cmd" | awk '
    $1 != "psql" { print "no"; exit }
    {
      for (i = 1; i <= NF; i++) {
        if ($i == "-h") {
	  host = $(i+1)
          if (host == "127.0.0.1" || host == "localhost") { print "safe"; exit }
          else { print "unsafe"; exit }
        }
      }
      print "safe"
    }
  ')
  tmux set-window-option allow-rename off
  tmux set-window-option automatic-rename off

  case $result in
    safe)
      PSQL_PROMPT_INDICATOR="🖥️"
      tmux rename-window "${PSQL_PROMPT_INDICATOR} psql"
      ;;
    unsafe)
      PSQL_PROMPT_INDICATOR="❌"
      tmux rename-window "${PSQL_PROMPT_INDICATOR} psql"
      ;;
    *)
      PSQL_PROMPT_INDICATOR=""
      #tmux rename-window "$ORIG_TMUX_WINDOW_NAME"
      ;;
  esac
}


preexec() {
  tmux set-window-option allow-rename on
  tmux set-window-option automatic-rename on
  #ORIG_TMUX_WINDOW_NAME="$(tmux display-message -p '#W')"
  #last_cmd="$1"
  check_psql_host $1
}


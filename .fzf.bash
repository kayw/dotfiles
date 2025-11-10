# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/kayw/.vim/bundle/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/kayw/.vim/bundle/fzf/bin"
fi

eval "$(fzf --bash)"

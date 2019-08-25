# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kayw/.vim/bundle/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/kayw/.vim/bundle/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/kayw/.vim/bundle/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/kayw/.vim/bundle/fzf/shell/key-bindings.bash"

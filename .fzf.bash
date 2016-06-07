# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kayw/.vim/bundle/fzf/bin* ]]; then
  export PATH="$PATH:/home/kayw/.vim/bundle/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/kayw/.vim/bundle/fzf/man* && -d "/home/kayw/.vim/bundle/fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/kayw/.vim/bundle/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/kayw/.vim/bundle/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/kayw/.vim/bundle/fzf/shell/key-bindings.bash"


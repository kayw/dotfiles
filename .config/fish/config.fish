# https://wiki.archlinux.org/title/Fish
if status is-interactive
  if command -q atuin; atuin init fish | source; end
end

set -U fish_greeting

# https://github.com/fish-shell/fish-shell/issues/5924#issuecomment-499491450
# https://github.com/fish-shell/fish-shell/pull/10302
function fish_should_add_to_history
    for cmd in ls cd ps du cat vim
       string match -qr "^$cmd" -- $argv; and return 1
    end
    return 0
end

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto -A'
# http://stackoverflow.com/questions/3455625/linux-command-to-print-directory-structure-in-the-form-of-a-tree
alias lst='ls -R | grep \':$\' | sed -e \'s/:$//\' -e \'s/[^-][^\/]*\//--/g\' -e \'s/^/   /\' -e \'s/-/|/\''
alias lss='find . -type f | grep -v ".git" | xargs du -b | sort -rn' #http://unix.stackexchange.com/questions/53737/how-to-list-all-files-in-the-size-order
alias grep='grep --color=auto'
alias kgit="GIT_DIR=$HOME/.local/share/dotfiles/.git GIT_WORK_TREE=~ command git $argv"
alias kubectl="kubectl --cache-dir=$HOME/.cache/kube $argv"
#complete -c kgit -w git

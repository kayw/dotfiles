#!/bin/sh
# merged from
#   https://bbs.archlinux.org/viewtopic.php?id=136351  tmux urxvt
#   https://bbs.archlinux.org/viewtopic.php?id=117448  urxvt startup

#xrdb -merge $HOME/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export _JAVA_AWT_WM_NONREPARENTING=1
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
export LANG=en_US.utf8
export LC_ALL=en_US.utf8
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec fcitx &

#https://bbs.archlinux.org/viewtopic.php?id=130562&p=3   frank/dotfiles/.xinitrc
xset +fp /usr/share/fonts/local/
xset fp rehash

command -v VBoxClient-all >/dev/null && VBoxClient-all
#export RXVT_SOCKET=/tmp/urxvtd-Arch
#urxvtd -q -o -f
if [[ -z "$TMUX" ]]; then
  #urxvtc -e tmux
  alacritty -e tmux &
else
  #urxvtc -e tmux att  #https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
  alacritty -e tmux att &
fi

exec $HOME/bin/start-dwm

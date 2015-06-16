#!/bin/sh
# sourced from 
#               https://bbs.archlinux.org/viewtopic.php?id=136351  tmux urxvt
xrdb -merge /home/kayw/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export LANG=en_US.utf8
export LC_ALL=en_US.utf8
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec fcitx &


VBoxClient-all
urxvtd -q -o -f &
if [[ -z "$TMUX" ]]; then
  tmux att
fi
urxvtc
exec /home/kayw/bin/start-dwm

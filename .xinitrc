#!/bin/bash
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

if [ -d $HOME/.local/share/xinitrc.d ]; then
  for f in $HOME/.local/share/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [[ -z "$TMUX" ]]; then
  alacritty -e tmux 2>&1 &
else
  alacritty -e tmux att 2>&1 &
fi

exec $HOME/.local/bin/start-dwm

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
#xrandr --output HDMI-0 --rotate left --right-of DP-4 --output DP-4
#xrandr --output DP-4 --pos 0x700
xrandr --output HDMI-0 --right-of DP-2 --output DP-2

command -v VBoxClient-all >/dev/null && VBoxClient-all
if [[ -z "$TMUX" ]]; then
  alacritty -o "window.position={y=700,x=0}" -e tmux &
else
  alacritty -e tmux att &
fi

exec $HOME/.local/bin/start-dwm

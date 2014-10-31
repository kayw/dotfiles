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
#exec uxterm -e screen -dR &
exec xterm -u8 -e screen -dR &
exec godoc -http=localhost:6060 &
while true; do
#	xsetroot -name "$( date +"%a %F %T" )"
#	http://stackoverflow.com/questions/5051040/dwm-xsetroot-cpu-usage-display-with-awk
xsetroot -name "Memory $(free -m | grep '^Mem' | awk '{print "total: " $2 "MB used: " $3"MB"}') | CPU $(top -bn 1 | grep -i '^%CPU' | tr -d 'usy,' | awk '{print "user " $2 ", sys " $3}') | Uptime: $(uptime | awk '{print $3}' | tr -d ',') | $( date +"%a %F %T %::z")"
	sleep 5 # Update every 5 seconds
done &
exec /home/kayw/dwm/dwm

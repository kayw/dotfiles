xrdb -merge /home/kayw/.Xresources
VBoxClient-all
xterm -e screen -dR &
#exec wmii
while true; do
#	xsetroot -name "$( date +"%a %F %T" )"
#	http://stackoverflow.com/questions/5051040/dwm-xsetroot-cpu-usage-display-with-awk
#xsetroot -name "Memory $(free -m | grep '^Mem' | awk '{print "total: " $2 "MB used: " $3"MB"}') | CPU $(top -bn 1 | grep '^Cpu' | tr -d 'usy,' | awk '{print "user " $2 ", sys " $3}') | Uptime: $(uptime | awk '{print $3}' | tr -d ',') | Now playing: $(ncmpcpp --now-playing | tr -d '(:[:digit:])') | $( date +"%a %F %T")"
xsetroot -name "Memory $(free -m | grep '^Mem' | awk '{print "total: " $2 "MB used: " $3"MB"}') | CPU $(top -bn 1 | grep '^Cpu' | tr -d 'usy,' | awk '{print "user " $2 ", sys " $3}') | Uptime: $(uptime | awk '{print $3}' | tr -d ',') | $( date +"%a %F %T")"
	sleep 5 # Update every 5 seconds
done &
exec /home/kayw/dwm/dwm

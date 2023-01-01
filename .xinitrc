while true
do
    xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    sleep 1
done &
nitrogen --restore &

killall wired
wired -r &

setxbmap us
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xrandr --dpi 144

exec dwm

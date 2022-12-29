while true
do
    xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    sleep 1
done &
nitrogen --restore &

setxbmap us
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources 

exec dwm

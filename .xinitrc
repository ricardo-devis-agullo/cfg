while true
do
    xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    sleep 1
done &
nitrogen --restore &

exec dwm

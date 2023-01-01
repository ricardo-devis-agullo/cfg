case $1 in
  96)
    sed -i 's/Xft.dpi:.*/Xft.dpi:       96/' ~/.Xresources
    sed -i 's/xrandr --dpi.*/xrandr --dpi 96/' ~/.xinitrc
    sed -i 's/monospace:size=[[:digit:]]\+/monospace:size=10/' ~/.config/dwm/config.h
    sed -i 's/monospace [[:digit:]]\+/monospace 10/' ~/.config/dwm/config.h
    ;;
  144)
    sed -i 's/Xft.dpi:.*/Xft.dpi:       144/' ~/.Xresources
    sed -i 's/xrandr --dpi.*/xrandr --dpi 144/' ~/.xinitrc
    sed -i 's/monospace:size=[[:digit:]]\+/monospace:size=14/' ~/.config/dwm/config.h
    sed -i 's/monospace [[:digit:]]\+/monospace 14/' ~/.config/dwm/config.h
    ;;
  *)
    echo "Invalid DPI (only 96 or 144 valid)."
    exit 1
    ;;
esac
case $1 in
  96)
    sed -i 's/Xft.dpi:.*/Xft.dpi:       96/' ~/.Xresources
    sed -i 's/xrandr --dpi.*/xrandr --dpi 96/' ~/.xinitrc

    sed -i 's/pixelsize=[[:digit:]]*/pixelsize=10/' ~/.config/dwm/config.h
    sed -i 's/Liberation Mono [[:digit:]]*/Liberation Mono 10/' ~/.config/dwm/config.h

    sed -i 's/pixelsize=[[:digit:]]*/pixelsize=10/' ~/.config/dmenu/config.h
    sed -i 's/Liberation Mono [[:digit:]]*/Liberation Mono 10/' ~/.config/dmenu/config.h
    ;;
  144)
    sed -i 's/Xft.dpi:.*/Xft.dpi:       144/' ~/.Xresources
    sed -i 's/xrandr --dpi.*/xrandr --dpi 144/' ~/.xinitrc

    sed -i 's/pixelsize=[[:digit:]]*/pixelsize=20/' ~/.config/dwm/config.h
    sed -i 's/Liberation Mono [[:digit:]]*/Liberation Mono 20/' ~/.config/dwm/config.h

    sed -i 's/pixelsize=[[:digit:]]*/pixelsize=20/' ~/.config/dmenu/config.h
    sed -i 's/Liberation Mono [[:digit:]]*/Liberation Mono 20/' ~/.config/dmenu/config.h
    ;;
  *)
    echo "Invalid DPI (only 96 or 144 valid)."
    exit 1
    ;;
esac
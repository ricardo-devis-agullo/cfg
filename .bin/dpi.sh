case $1 in
  96)
    sed -i 's/Xft.dpi:.*/Xft.dpi:       96/' ~/.Xresources
    sed -i 's/xrandr --dpi.*/xrandr --dpi 96/' ~/.xinitrc
    ;;
  144)
    sed -i 's/Xft.dpi:.*/Xft.dpi:       144/' ~/.Xresources
    sed -i 's/xrandr --dpi.*/xrandr --dpi 144/' ~/.xinitrc
    ;;
  *)
    echo "Invalid DPI (only 96 or 144 valid)."
    exit 1
    ;;
esac
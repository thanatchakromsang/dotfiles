#!/bin/bash
PICTURES="$HOME/Pictures/Wallpaper"

case "$1" in
    single)
        PICTURES="$HOME/Pictures/Wallpaper"
        ;;
    dual)
        PICTURES="$HOME/Pictures/Wallpaper"
        ;;
    *)
        ;;
esac

# Random pictures in folder
# find "$PICTURES" -type f | shuf -n 1 | xargs feh --bg-fill &> /dev/null

feh --bg-fill $HOME/Pictures/Wallpaper/abstract/wallhaven-760704_1920x1080.png --bg-fill $HOME/Pictures/Wallpaper/abstract/wallhaven-760704_1920x1080.png


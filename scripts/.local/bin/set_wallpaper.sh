#!/bin/bash

if xrandr | grep '1440x2560' >/dev/null
then
    # detected a rotated monitor
    # monitors go from left to right. vertical wallpaper first, then the other
    #feh --bg-scale ~/Pictures/wallpapers/farn-vertical.jpg ~/Pictures/wallpapers/farn.jpg
    feh --bg-scale ~/Pictures/wallpapers/farn.jpg ~/Pictures/wallpapers/farn-vertical.jpg
else
    feh --bg-scale ~/Pictures/wallpapers/farn.jpg
fi

#!/bin/bash

if xrandr | grep '1440x2560' > /dev/null ;
then
    # detected a rotated monitor
    feh --bg-scale ~/Pictures/wallpapers/farn.jpg ~/Pictures/wallpapers/farn-vertical.jpg 
else
    feh --bg-scale ~/Pictures/wallpapers/farn.jpg
fi



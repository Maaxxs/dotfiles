#!/bin/bash

# check for differences to match on with 
# xrandr | grep -E 'DP-[2,4]'
# monitors are connected with DP-2 and DP-4

if xrandr | grep 'DP-2.*2560x1440'; then
    # right display is in normal rotation. Rotate left now
    # xrandr --output DP-4 --primary --output DP-2 --right-of DP-4 --rotate left
    # with correct vertical offset:
    xrandr --output DP-4 --primary --pos 0x0 --output DP-2 --rotate left --pos 2560x-490
else
    xrandr --output DP-4 --primary --output DP-2 --right-of DP-4 --rotate normal
fi

#!/bin/bash
set -e
trap cleanup HUP INT TERM

function cleanup {
    rm -f /tmp/lockscreen.png
}

grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') /tmp/lockscreen.png
convert -blur 0x8 /tmp/lockscreen.png /tmp/lockscreen.png
convert -composite /tmp/lockscreen.png ~/Pictures/wallpapers/capslock-centered.png /tmp/lockscreen.png
swaylock -Kfi /tmp/lockscreen.png
cleanup

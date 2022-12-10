#!/usr/bin/env bash

# Taken from https://gitlab.com/jD91mZM2/xidlehook

# I hardcode these values
# Only exported variables can be used within the timer's command.
# export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 60 seconds, undim if user becomes active` \
  --timer 900 \
    'xrandr --output DP-4 --brightness .2 --output DP-2 --brightness 0.2' \
    'xrandr --output DP-4 --brightness 1 --output DP-2 --brightness 1' \
  `# Undim & lock after 10 more seconds` \
  --timer 30 \
    'xrandr --output DP-4 --brightness 1 --output DP-2 --brightness 1; convert /home/max/wallpapers/funky-colors.webp RGB:- | i3lock --raw 5120x1440:rgb --image /dev/stdin' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 3600 \
    'systemctl suspend' \
    ''



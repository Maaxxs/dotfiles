#/bin/sh

ACTIVE=$(swaymsg -t get_outputs | jq '.[] | select(.name == "eDP-1") | .active')

if $ACTIVE; then
    swaymsg 'output eDP-1 disable'
else
    swaymsg 'output eDP-1 enable'
fi

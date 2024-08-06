#!/usr/bin/env bash

PROFILES=$(rg '^profile' "$HOME/.config/kanshi/config" | cut -d' ' -f 2)

PROFILE=$(echo -e "$PROFILES" | rofi -dmenu -i -p "Select Profile")

[ -z "$PROFILE" ] && exit

kanshictl switch "$PROFILE"




#!/usr/bin/env bash

WHAT="$1"

case "$WHAT" in
    pdf)
        PDF=$(fd . -e pdf "$HOME/Documents/" "$HOME/nc/" | sed -e "s|$HOME/||" | rofi -dmenu -i -p "Search" -theme-str 'window {width: 80%;}')
        [ -z "$PDF" ] && exit
        xdg-open "$HOME/$PDF"
        ;;
    rfc)
        RFC_PATH="/usr/share/doc/rfc/"
        DOC=$(fd . -e pdf -e txt "$RFC_PATH" | sed -e "s|$RFC_PATH||" | rofi -dmenu -i -p "Open RFC")
        [ -z "$DOC" ] && exit
        alacritty -e nvim "$RFC_PATH$DOC"
        ;;
    uni)
        SEARCH_PATH="$HOME/nc/AIM/"
        DOC=$(fd . -e pdf "$SEARCH_PATH" | sed -e "s|$SEARCH_PATH||" | rofi -dmenu -i -p "Search AIM")
        [ -z "$DOC" ] && exit
        xdg-open "$SEARCH_PATH/$DOC"
        ;;
esac



#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Call script with an argument that is a mailto: string"
    echo "Example: ./mailto.sh mailto:some@email.com?Subject=optional"
    exit 1
fi

# $1 : mailto:some@email.com
# $1 : mailto:some@email.com?Subject:Hi
MAILTO=$1

ACCOUNTS=$(find ~/.config/neomutt/accounts/ -type f -exec basename {} \;)
CHOICE=$(echo -e "copy\n${ACCOUNTS}" | rofi -dmenu -i -p "From Account")

if [ -z "$CHOICE" ]; then
    # cancelled account selection
    exit
fi

export EDITOR=nvim

case "$CHOICE" in
    "copy")
        EMAIL=$(echo "$MAILTO" | sed -E 's/^mailto://; s/\?.*$//')
        wl-copy "$EMAIL"
        notify-send "Copied Email to Clipboard" "$EMAIL"
        ;;
    *)
        alacritty -e neomutt -F "$HOME/.config/neomutt/neomuttrc" -F "$HOME/.config/neomutt/accounts/$CHOICE" "$MAILTO"
        ;;
esac



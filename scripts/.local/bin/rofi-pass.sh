#!/usr/bin/env bash

PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

entry=$(
    find "$PASSWORD_STORE_DIR" -type f -name "*.gpg" \
        | sed "s|^$PASSWORD_STORE_DIR/||" \
        | sed 's/\.gpg$//' \
        | sort \
        | rofi -dmenu -p "Password"
)

[ -n "$entry" ] && pass -c "$entry"

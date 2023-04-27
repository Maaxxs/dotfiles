#!/usr/bin/env bash
#
# Written for Wayland. Hence, it requires `gsettings`.

set -euo pipefail

MODE=$(gsettings get org.gnome.desktop.interface color-scheme | tr -d "'" | cut -d'-' -f2)

if [ "$MODE" == "light" ]; then
    echo "[*] Changing theme to 'dark'"
    notify-send "Changing Theme to Dark"

    sed -ri 's/^colors: \*\w+$/colors: \*catpuccin_mocha/' ~/.config/alacritty/alacritty.yml
    gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
else
    echo "[*] Changing theme to 'light'"
    notify-send "Changing Theme to Light"

    sed -ri 's/^colors: \*\w+$/colors: \*catpuccin_latte/' ~/.config/alacritty/alacritty.yml
    gsettings set org.gnome.desktop.interface gtk-theme "Arc"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
fi


#!/usr/bin/env bash
#
# Written for Wayland. Hence, it requires `gsettings`.

#set -euo pipefail

MODE=$(gsettings get org.gnome.desktop.interface color-scheme | tr -d "'" | cut -d'-' -f2)

if [ "$MODE" == "light" ]; then
    echo "[*] Changing theme to 'dark'"
    notify-send "Changing Theme to Dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

    sed -ri 's/.*alabaster_.*/\"\~\/\.config\/alacritty\/alabaster_dark\.toml\",/' ~/.config/alacritty/alacritty.toml
    sed -ri 's/^vim\.opt\.background\s?=\s?"light"$/vim\.opt\.background = "dark"/' ~/.config/nvim/init.lua
    # sed -ri 's/(^vim\.cmd\.colorscheme\(\")base16-google-light\"\)$/\1sonokai\"\)/' ~/.config/nvim/init.lua

    pkill swaybg
    swaybg --output \* --image "$HOME/Pictures/wallpaper/firewatch.png" --mode fit
else
    echo "[*] Changing theme to 'light'"
    notify-send "Changing Theme to Light"
    gsettings set org.gnome.desktop.interface gtk-theme "Arc"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

    sed -ri 's/.*alabaster_.*/\"\~\/\.config\/alacritty\/alabaster_light\.toml\",/' ~/.config/alacritty/alacritty.toml
    sed -ri 's/^vim\.opt\.background\s?=\s?"dark"$/vim\.opt\.background = "light"/' ~/.config/nvim/init.lua
    # sed -ri 's/(^vim\.cmd\.colorscheme\(\")sonokai\"\)$/\1base16-google-light\"\)/' ~/.config/nvim/init.lua

    pkill swaybg
    swaybg --output \* --image "$HOME/Pictures/wallpaper/firewatch-light.png" --mode fit
fi


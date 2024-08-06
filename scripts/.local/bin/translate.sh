#!/usr/bin/env bash

if ! nc -z 127.0.0.1 8000 2>/dev/null; then
    notify-send "Connection failed" "Is the API server running?"
    exit 1
fi

word="$1"
meaning=$("$HOME"/.cargo/bin/lookup -t de "$word")

notify-send "Translate \"$1\"" "$meaning"

#!/usr/bin/env bash

set -euo pipefail

pid=$(ps -u "$USER" -o pid,comm | rofi -dmenu -i -p "Kill Process" | sed -E 's/^ *//' | cut -d ' ' -f 1)

echo "pid: ${pid:-no pid}"

if [ -n "$pid" ]; then
    kill -9 "$pid"
fi


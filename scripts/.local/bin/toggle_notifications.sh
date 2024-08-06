#!/bin/env sh

MUTED=$(dunstctl is-paused)

# PID=$(pgrep toggle_notifications.sh && pkill toggle_notifications.sh)
# [ -n "$PID" ] && kill -9 "$PID"

if [ "$MUTED" = "false" ]; then
    echo "Muting notifications now"
    dunstctl close-all
    notify-send -i /usr/share/icons/Adwaita/symbolic/status/notifications-disabled-symbolic.svg --expire-time 2000 "Muting Notifications"
    sleep 2
    dunstctl set-paused true
else
    echo "Enabling notifications"
    notify-send -i /usr/share/icons/Arc/status/symbolic/notification-disabled-symbolic.svg --expire-time 2000 "Enable Notifications"
    dunstctl set-paused false
fi


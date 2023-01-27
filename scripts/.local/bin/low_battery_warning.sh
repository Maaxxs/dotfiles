#!/bin/sh

set -eu pipefail

# warning level in percentage
WARNING_PERC=10

PERC=$(cat /sys/class/power_supply/BAT1/capacity)

if [ "$PERC" -le $WARNING_PERC ]; then
  notify-send -u critical "Low battery"
fi


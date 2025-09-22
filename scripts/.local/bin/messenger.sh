#!/bin/bash

# Move the Signal app window to current workspace.
# If it does not exist, yet, start Signal.

# apparently, the name can be "Signal (1)" for whatever reason.
#
# CONTAINER_ID=$(swaymsg -t get_tree \
#   | jq '.. | select(.name? == "Signal" and .app_id? == "signal") | .id')

CONTAINER_ID=$(swaymsg -t get_tree \
  | jq '.. | select(.app_id? == "signal") | .id')

if [ -z "$CONTAINER_ID" ]
then
    gtk-launch signal-desktop
else
    swaymsg "[con_id=$CONTAINER_ID]" move container to workspace current
fi


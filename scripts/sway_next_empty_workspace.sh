#!/bin/bash

set -euo pipefail

# new: create new workspace (default)
# move: move container to new workspace
opt="new"

while [ $# -gt 0 ]; do
    case $1 in
        "move") opt="move" ;;
        "new") opt="new" ;;
        *)
            echo "$0 [new|move]"
            exit 1
            ;;
    esac
    # go to next parameter. here only useful to exit loop
    shift
done

# used to send a notification if now workspace is found
found_ws=false

# get sorted string of workspaces.
# may look like "1 2 3 4" or "2 4 6 9 10" (workspace number 10)
used_ws=$(swaymsg -t get_workspaces | jq '.[].num' | sort -n | tr '\n' ' ')
#echo "workspace string: $used_ws"

# create workspace with lowest available number
for ws in {1..10}; do
    [[ $used_ws =~ "$ws " ]] && continue

    found_ws=true
    case $opt in
        "new") swaymsg workspace number "$ws" ;;
        "move") swaymsg move container to workspace number "$ws"; swaymsg workspace number "$ws" ;;
    esac
    break
done

if ! $found_ws; then
    dunstify "Could not create new workspace" "All 10 workspaces are in use"
fi

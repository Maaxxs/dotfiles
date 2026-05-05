#!/bin/bash
# Execute this script via a bindsym binding.
#
# Set the following sway option:
# smart_gaps inverse_outer
# The script will add horizontal padding but it will only have an effect
# if there is just a single window on a workspace.

# The script gets the current monitor width, and centers the focused window by
# adding a 25% padding to the left and right.

monitor_dimensions=$( swaymsg -t get_workspaces |
    jq -r '.. | select(.focused?) | select(.type=="workspace") | .rect | "\(.width)x\(.height)"' )
monitor_width=${monitor_dimensions%x*}
monitor_height=${monitor_dimensions#*x}

# echo $monitor_dimensions
# echo $monitor_width
# echo $monitor_height

# integer only divison, no floating point here.
padding=$(( monitor_width / 4 ))

case "$1" in
    horizontal)
    swaymsg "gaps horizontal current toggle $padding"
        ;;
    vertical)
        swaymsg "gaps vertical current toggle $padding"
        ;;
    top)
        swaymsg "gaps bottom current toggle $(( monitor_height / 2 ))"
        ;;
    *)
        echo "Not Implemented"
        ;;
esac

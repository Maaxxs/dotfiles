#!/usr/bin/env bash
# https://gitlab.com/wef/dotfiles/-/blob/master/bin/sway-move-to
# shellcheck disable=SC2034
#TIME_STAMP="20220910.062755"

# Copyright (C) 2020-2021 Bob Hepple <bob dot hepple at gmail dot com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

initialise() {
    PROG=$(basename "$0")
    USAGE="Usage: $PROG move a window to top-right, bottom-right, bottom-left, left,
right, mid-top, mid-left, mid-right, mid-bottom, cent(re|er) (sway lacks a way to do it!).
top-left is also provided for completeness although sway supports that."

    case $1 in
        -h|--help)
            echo "$USAGE"
            exit 0
            ;;
        top-left|top-right|bottom-right|bottom-left|top|bottom|left|right|mid-top|mid-left|mid-right|mid-bottom|cent*)
            command="$1"
            ;;
        *)
            echo "$PROG: bad argument" >&2
            exit 1
            ;;
    esac

    return 0
}

initialise "$@"
monitor_dimensions=$( swaymsg -t get_workspaces |
    jq -r '.. | select(.focused?) | select(.type=="workspace") | .rect | "\(.width)x\(.height)"' )
monitor_width=${monitor_dimensions%x*}
monitor_height=${monitor_dimensions#*x}

mapfile -t win_param < <( swaymsg -t get_tree |
        jq -r '.. | select(.type?) | select(.focused?)|.rect.x, .rect.y, .rect.width, .rect.height, .deco_rect.height, .type' )

new_x=${win_param[0]}
new_y=${win_param[1]}
win_width=${win_param[2]}
win_height=${win_param[3]}
deco_height=${win_param[4]}
win_type=${win_param[5]}

#echo "$win_height $win_width $deco_height"
case "$win_type" in
    "floating_con")
        case $command in
            top)
                new_y=0
                ;;

            bottom)
                new_y=$(( monitor_height - win_height - deco_height ))
                ;;

            left)
                new_x=0
                new_y=$(( new_y - deco_height ))
                ;;

            right)
                new_x=$(( monitor_width -  win_width ))
                new_y=$(( new_y - deco_height ))
                ;;

            mid-top)
                new_x=$(( ( monitor_width -  win_width ) / 2))
                new_y=0
                ;;

            mid-left)
                new_x=0
                new_y=$(( ( monitor_height - win_height - deco_height ) / 2))
                ;;

            mid-right)
                new_x=$(( monitor_width -  win_width ))
                new_y=$(( ( monitor_height - win_height - deco_height ) / 2))
                ;;

            mid-bottom)
                new_x=$(( ( monitor_width -  win_width ) / 2 ))
                new_y=$(( monitor_height - win_height - deco_height ))
                ;;

            top-left)
                new_x=0
                new_y=0
                ;;

            top-right)
                new_x=$(( monitor_width -  win_width ))
                new_y=0
                ;;

            bottom-right)
                new_x=$(( monitor_width -  win_width ))
                new_y=$(( monitor_height - win_height - deco_height ))
                ;;

            bottom-left)
                new_x=0
                new_y=$(( monitor_height - win_height - deco_height ))
                ;;

            cent*)
                new_x=$(( ( monitor_width -  win_width ) / 2 ))
                new_y=$(( ( monitor_height - win_height - deco_height ) / 2 ))
                ;;

        esac

        swaymsg "move position $new_x $new_y"
        ;;

    "con")
        case $command in
            top|mid-top)
                swaymsg "move up"
                ;;

            bottom|mid-bottom)
                swaymsg "move down"
                ;;

            left|mid-left)
                swaymsg "move left"
                ;;

            right|mid-right)
                swaymsg "move right"
                ;;

            top-left)
                swaymsg "move up"
                swaymsg "move left"
                ;;

            top-right)
                swaymsg "move up"
                swaymsg "move right"
                ;;

            bottom-left)
                swaymsg "move down"
                swaymsg "move left"
                ;;

            bottom-right)
                swaymsg "move right"
                swaymsg "move down"
                ;;

            cent*)
                : # not sure what can be done here
                ;;
        esac
esac

# Local Variables:
# mode: shell-script
# time-stamp-pattern: "4/TIME_STAMP=\"%:y%02m%02d.%02H%02M%02S\""
# eval: (add-hook 'before-save-hook 'time-stamp)
# End:



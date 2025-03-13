#!/bin/bash
#
# Import .ics file to Nextcloud Calendar
# Found via @hannob
# https://github.com/hannob/scripts/blob/ce940fae06e5510fdf70d51482458b10c21ad0d8/ics2nc
#
# Needs a config file ~/.ics2ncrc with settings like this:
# HOST="example.com"
# USER="exampleuser"
# CALENDAR="defaultcalendar"
# PASS="somepassword"
# GUIMSG="0"
#
# SPDX-License-Identifier: 0BSD
#
set -euo pipefail

source ~/.ics2ncrc

if [ -z "${1-}" ]; then
	echo "Usage:"
	echo "  $0 [ics_file]"
	exit 1
fi

URL="https://$HOST/remote.php/dav/calendars/$USER/$CALENDAR/$(uuidgen -r)"

out=$(curl -s -X PUT \
	-u "$USER:$PASS" \
	-H "Content-Type: text/calendar;charset=UTF-8" \
	-T <(grep -v '^METHOD:' $1) \
	$URL)

if [ -n "$out" ]; then
	echo "$out"
	if [ "$GUIMSG" = "1" ]; then
		zenity --text-info --title "ics import failed" --filename <(echo "$out")
	fi
else
	if [ "$GUIMSG" = "1" ]; then
		zenity --notification --text "ics import successful"
	fi
fi

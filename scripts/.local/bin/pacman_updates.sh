#!/bin/bash

packages=$(checkupdates)
count=$(echo "$packages" | wc -l)

# echo "count: $count"
# echo "$packages"

if [ "$count" -eq 0 ] || [ -z "$packages" ]; then
    notify-send "No upgradable packages found"
    # correct $count to 0 if $packages was empty
    count=0
elif [ "$count" -eq 1 ]; then
    notify-send "One update found" "$packages"
elif [ "$count" -le 10 ]; then
    notify-send "$count udpates found" "$packages"
else
    notify-send "$count updates found"
fi

# print $count for waybar
echo "$count"


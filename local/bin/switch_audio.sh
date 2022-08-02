#!/bin/bash

audio_devices=(
    "alsa_output.pci-0000_00_1b.0.analog-stereo"
    "alsa_output.usb-Logitech_Logitech_G430_Gaming_Headset-00.analog-stereo"
)

current_audio=$(pactl get-default-sink)
for index in "${!audio_devices[@]}"; do
    if [[ "${audio_devices[$index]}" = "$current_audio" ]]; then
        current_audio_index=$index
        break
    fi
done

if [[ "$current_audio_index" = "" ]]; then
    pactl set-default-sink "${audio_devices[0]}"
else
    index=$(((index + 1) % ${#audio_devices[@]}))
    pactl set-default-sink "${audio_devices[$index]}"
fi

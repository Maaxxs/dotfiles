#!/bin/bash

#LOGFILE="$HOME/audio.log"
#exec > >(tee "$LOGFILE") 2>&1

audio_devices=(
    "alsa_output.pci-0000_00_1f.3.analog-stereo" # laptop/headphone jack
    "alsa_output.usb-Creative_Technology_Ltd_Sound_BlasterX_G1_00100283-00.analog-stereo"
    "bluez_output.AC_BF_71_0B_93_94.1" # bluetooth output
)

case "$1" in
    cycle)
        current_audio=$(pactl get-default-sink)
        echo "current audio: $current_audio"

        for index in "${!audio_devices[@]}"
        do
            if [[ "${audio_devices[$index]}" = "$current_audio" ]]; then
                current_audio_index=$index
                break
            fi
        done

        if [[ "$current_audio_index" = "" ]]; then
            echo "New default sink: ${audio_devices[0]}"
            pactl set-default-sink "${audio_devices[0]}"
        else
            # rotate through audio devices
            index=$(((index + 1) % ${#audio_devices[@]}))
            echo "New default sink: ${audio_devices[$index]}"
            pactl set-default-sink "${audio_devices[$index]}"
        fi
        ;;
    *)
        OUTPUT=$(echo "${audio_devices[@]}" | rofi -sep ' ' -dmenu -i -p "Select Output")
        echo "$OUTPUT"
        pactl set-default-sink "$OUTPUT"
        ;;
esac

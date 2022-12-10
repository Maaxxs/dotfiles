#
# Inspired by https://git.sr.ht/~oscarcp/ghostfiles/tree/master/item/sway_wm/scripts/sway_bar.sh
#
#############
# VARIABLES #
#############

# Keyboard input name
keyboard_input_name="1:1:AT_Translated_Set_2_keyboard"
# interval in seconds to update the weather. 1800s = 30min
interval=1800
# interval to check for new updates
update_interval=1800

# Two information are saved in the the following files.
# 1) first  line: datetime when the weather was last upated
# 2) second line: the last weather/update counter itself
weather_file="$HOME/.config/i3/last_weather_check"
checkupdate_file="$HOME/.config/i3/last_update_check"

# Automatically set variables
current_date_unix=$(date +%s)

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
# uptime symbol:  ↑

#############
# Commands
#############

# Produces "21 days", for example
uptime="💡 $(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5) hours on"

kernel_version="🐧 $(uname -r | cut -d '-' -f1)"

# Check for updates
last_download_unix=$(date -d "$(head -n1 $checkupdate_file)" +%s)
difference=$((current_date_unix - last_download_unix))
if [[ $difference -lt $update_interval ]]; then
    updates=$(tail -n1 "$checkupdate_file")
else
    current_date=$(date '+%Y-%m-%d %H:%M:%S')
    updates=" $(checkupdates | wc -l)"
    echo -e "$current_date\n$updates" > "$checkupdate_file"
fi


# Date and time
date_and_week=$(date "+%Y-%m-%d (w%-V)")
current_time=$(date "+%H:%M")

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio and multimedia
audio_volume=$(pamixer --sink $(pactl get-default-sink) --get-volume)
audio_is_muted=$(pamixer --sink $(pactl get-default-sink) --get-mute)
media_artist=$(playerctl metadata artist)
media_song=$(playerctl metadata title)
player_status=$(playerctl status)

# Network
network=$(ip route get 1.1.1.1 | grep dev | cut -d ' ' -f 7)
interface_easyname=$(ip route get 1.1.1.1 | grep dev | cut -d ' ' -f 5)

# Othersr

# language="  $(swaymsg -r -t get_inputs | awk '/1:1:AT_Translated_Set_2_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b1:1:AT_Translated_Set_2_keyboard\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')"
language="  $()"

# Weather
# * If the `head` command fails because the file das not exist, then `date -d`
#   will get an empty string. This will always result in the unix timestamp of
#   the current day at time 00:00:00. 
# * If `head` reads an incorrect date, then `date` will fail and the script 
#   fails because the `difference` calculation has an syntax error. 
# Don't mess with the created files :)
#last_download_unix=$(date -d "$(head -n1 $weather_file)" +%s)
#difference=$((current_date_unix - last_download_unix))
#if [[ $difference -lt $interval ]]; then
#    weather=$(tail -n1 "$weather_file")
#else
#    current_date=$(date '+%Y-%m-%d %H:%M:%S')
#    weather=$(curl https://wttr.in/91315\?format\=1)
#    echo -e "$current_date\n$weather" > "$weather_file"
#fi

if [ $battery_status = "discharging" ]; then
    # old symbol: ⚠
    battery_pluggedin='🔋'
else
    battery_pluggedin='⚡'
fi

if ! [ $network ]; then
   network_active="⛔"
else
   network_active="⇆ $network"
fi

if [ $player_status = "Playing" ]; then
    song_status='▶'
elif [ $player_status = "Paused" ]; then
    song_status='⏸'
else
    song_status='⏹'
fi

if [ $audio_is_muted = "true" ]; then
    audio_active='🔇'
else
    audio_active='🔊'
fi

echo "🎧 $song_status $media_artist - $media_song | $weather | $language | $uptime $kernel_version | $updates | $network_active $interface_easyname | $audio_active $audio_volume% | $battery_pluggedin $battery_charge | $date_and_week 🕘 $current_time"




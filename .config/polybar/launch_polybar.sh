#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar --reload bar1 & 
polybar --reload bar2 & 

#!/bin/bash

# Script that adjust the brightness of my external monitor.
# It writes the new value to stdout and also to the CONF_FILE.

CONF_FILE="$HOME/.config/i3status/dell_brightness"
WOB_SOCK="$XDG_RUNTIME_DIR/wob.sock"
DEBUG=0

debug() {
    if [ $DEBUG -eq 1 ]
    then
        echo "$@"
    fi
}

VALUE=-1
bounded_add() {
    CURRENT="$1"
    STEP="$2"

    VALUE=$(( CURRENT + STEP ))
    if [ "$VALUE" -lt 0 ]
    then
        VALUE=0
    elif [ $VALUE -gt 100 ]
    then
        VALUE=100
    fi
}

if ! [ -e "$CONF_FILE" ]
then
    # init with current brightness
    VAL=$(ddcutil getvcp 10 | grep -Eo 'current value =[^,]+' | tr -d ' ' | cut -d '=' -f 2)
    echo "$VAL" | tee "$CONF_FILE"
fi

case "$1" in
    increase|inc)
        CURRENT=$(cat "$CONF_FILE")
        STEP="${2:-10}"
        bounded_add "$CURRENT" "$STEP"

        echo "$VALUE" | tee "$CONF_FILE" | tee "$WOB_SOCK"
        debug "old=$CURRENT ; new=$VALUE"
        ddcutil setvcp 10 "$VALUE"
        ;;
    decrease|dec)
        CURRENT=$(cat "$CONF_FILE")
        STEP="${2:--10}"
        bounded_add "$CURRENT" "$STEP"

        echo "$VALUE" | tee "$CONF_FILE" | tee "$WOB_SOCK"
        debug "old=$CURRENT ; new=$VALUE"
        ddcutil setvcp 10 "$VALUE" &
        ;;
    set)
        CURRENT=$(cat "$CONF_FILE")
        VALUE=${2:--1}
        if [ "$VALUE" -eq -1 ]
        then
                debug "'set' option requires second numerical parameter as value"
        fi
        echo "$VALUE" | tee "$CONF_FILE" | tee "$WOB_SOCK"
        debug "old=$CURRENT ; new=$VALUE"
        ddcutil setvcp 10 "$VALUE" &
        ;;
    *)
        # not implemented
        debug "Not implemented"
        ;;
esac


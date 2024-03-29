#!/bin/sh

SINK="$(pactl get-default-sink)"
SKIP=

case "$1" in
    m*) pactl set-sink-mute "$SINK" "$2"
        SKIP=1 ;;
    inc) SIGN='+' ;;
    dec) SIGN='-' ;;
esac

[ -z "$SKIP" ] && \
    pactl set-sink-volume "$SINK" "${SIGN}${2}%"

kill -36 "$(pidof dwmblocks)"

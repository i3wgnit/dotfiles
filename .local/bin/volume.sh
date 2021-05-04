#!/bin/sh

SINK="$(pactl list short sinks | grep 'alsa_output' | cut -f 1)"

case "$1" in
    change) pactl set-sink-volume "$SINK" "$2" ;;
    mute) pactl set-sink-mute "$SINK" "$2" ;;
esac

kill -36 "$(pidof dwmblocks)"

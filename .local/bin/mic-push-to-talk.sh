#!/bin/sh

SOURCE="$(pactl list short sources | grep 'alsa_input' | cut -f 1)"

case "$1" in
    on) pactl set-source-mute "$SOURCE" 0 ;;
    off) pactl set-source-mute "$SOURCE" 1 ;;
esac

kill -35 "$(pidof dwmblocks)"

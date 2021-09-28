#!/bin/sh

SOURCE="$(pactl list short sources | grep 'alsa_input' | cut -f 1)"

pactl list short sources | grep 'alsa_input' | cut -f 1 | \
    case "$1" in
        on) xargs -P 0 -d '\n' -I '{}' pactl set-source-mute '{}' 0 ;;
        off) xargs -P 0 -d '\n' -I '{}' pactl set-source-mute '{}' 1 ;;
    esac

kill -35 "$(pidof dwmblocks)"

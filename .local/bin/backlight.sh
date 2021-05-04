#!/bin/sh

# Requires acpilight and udev rules

CTRL=

[ "$1" = kbd ] && {
    shift
    CTRL="-ctrl $(xbacklight -list | grep '::kbd_backlight')"
}

case "$1" in
    inc) OPT='-inc' ;;
    dec) OPT='-dec' ;;
esac

xbacklight $CTRL "$OPT" "$2"

kill -37 "$(pidof dwmblocks)"

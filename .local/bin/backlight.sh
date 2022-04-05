#!/bin/sh

# Requires acpilight and udev rules

XBACKLIGHT='xbacklight'
xbacklight_with_ctrl() {
    xbacklight -ctrl "$(xbacklight -list | grep '::kbd_backlight')" "$@"
}

[ "$1" = kbd ] && {
    shift
    XBACKLIGHT='xbacklight_with_ctrl'
}

case "$1" in
    inc) OPT='-inc' ;;
    dec) OPT='-dec' ;;
esac

"$XBACKLIGHT" "$OPT" "$2"

kill -37 "$(pidof dwmblocks)"

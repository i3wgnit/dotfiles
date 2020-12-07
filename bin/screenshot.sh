#!/bin/sh

PRINT_FILE="$HOME"/Pictures/screenshots/"$(date +%Y%m%d-%H%M%S)".png
print_xclip() {
    xclip -t image/png -selection c
}
MAIM_CMD='maim'

SELECTION=${2:-"$(printf 'screen\nwindow\narea' | dmenu)"}
[ -z "$selection" ] && exit

OUTPUT=${1:-"$(printf 'file\nclip' | dmenu)"}
[ -z "$OUTPUT" ] && exit

case "$OUTPUT" in
    file) case "$SELECTION" in
        screen) maim -qud 1 "$PRINT_FILE" ;;
        window) maim -ui "$(xdotool getactivewindow)" "$PRINT_FILE" ;;
        area) maim -us "$PRINT_FILE" ;;
        esac;;
    clip) case "$SELECTION" in
        screen) maim -qud 1 | print_xclip ;;
        window) maim -ui "$(xdotool getactivewindow)" | print_xclip ;;
        area) maim -us | print_xclip ;;
        esac;;
esac

notify-send \
    'Screenshot Captured' \
    "of ${SELECTION} to ${OUTPUT}"

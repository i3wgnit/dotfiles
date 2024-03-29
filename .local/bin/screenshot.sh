#!/bin/sh

PRINT_FILE="$HOME"/Pictures/screenshots/"$(date +%Y%m%d-%H%M%S)".png
print_xclip() {
    xclip -t image/png -selection c
}

SELECTION=${2:-"$(printf 'screen\nwindow\narea' | dmenu)"}
[ -z "$SELECTION" ] && exit

OUTPUT=${1:-"$(printf 'file\nclipboard' | dmenu)"}
[ -z "$OUTPUT" ] && exit

case "$OUTPUT" in
    file) case "$SELECTION" in
        screen) maim -qud 1 "$PRINT_FILE" ;;
        window) maim -ui "$(xdotool getactivewindow)" "$PRINT_FILE" ;;
        area) maim -us "$PRINT_FILE" ;;
        *) exit 1 ;;
        esac;;
    clip*) case "$SELECTION" in
        screen) maim -qud 1 | print_xclip ;;
        window) maim -ui "$(xdotool getactivewindow)" | print_xclip ;;
        area) maim -us | print_xclip ;;
        *) exit 1 ;;
        esac;;
esac

notify-send \
    -c transient \
    'Screenshot Captured' \
    "of ${SELECTION} to ${OUTPUT}"

#!/bin/sh

print_file="$HOME"/Pictures/screenshots/"$(date +%Y%m%d-%H%M%S)".png
print_xclip() {
    xclip -t image/png -selection c
}
maim_cmd="maim"

selection=${2:-"$(echo "screen\nwindow\nselect" | dmenu)"}
[ -z "$selection" ] && exit

output=${1:-"$(echo "file\nclip" | dmenu)"}
[ -z "$output" ] && exit

case "$output" in
    file) case "$selection" in
        screen) maim -qud 1 "$print_file" ;;
        window) maim -ui "$(xdotool getactivewindow)" "$print_file" ;;
        select) maim -us "$print_file" ;;
        esac;;
    clip) case "$selection" in
        screen) maim -qud 1 | print_xclip ;;
        window) maim -ui "$(xdotool getactivewindow)" | print_xclip ;;
        select) maim -us | print_xclip ;;
        esac;;
esac

# notify-send \
#     "Screenshot Captured" \
#     "of ${selection} to ${output}"


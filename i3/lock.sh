#!/bin/bash
scrot /tmp/screen.png

convert /tmp/screen.png -spread 12 -median 3 -paint 2 /tmp/screen.png
[[ -f ~/.config/i3/lock.png ]] && convert /tmp/screen.png ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png

i3lock -uei /tmp/screen.png

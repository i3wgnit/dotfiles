#!/bin/bash
maim /tmp/screen.png -d 0.125

#convert /tmp/screen.png -spread 12 -median 3 -paint 2 /tmp/screen.png
#convert /tmp/screen.png  -spread 3 -median 4 /tmp/screen.png
[[ -f ~/.dotfiles/bin/lock.png ]] && \
    convert /tmp/screen.png -spread 3 -median 4 \
    ~/.dotfiles/bin/lock.png -gravity center -composite -matte \
    /tmp/screen.png || \
    convert /tmp/screen.png -spread 3 -median 4 \
    /tmp/screen.png

i3lock -fec 000000 -i /tmp/screen.png


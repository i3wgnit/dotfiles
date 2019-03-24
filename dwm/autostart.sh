#!/bin/bash

cd

~/.dotfiles/bin/wallpaper.sh

# setsid -f emacs --daemon
setsid -f rescuetime
setsid -f redshift-qt
setsid -f dunst
CM_SELECTIONS=clipboard setsid -f clipmenud
# setsid -f compton -b
# setsid -f qbittorrent-nox -d --webui-port=7890

i3blocks | ~/.config/dwm/status.py &


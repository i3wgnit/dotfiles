#!/bin/bash

cd

~/.dotfiles/bin/wallpaper.sh

pulseaudio --kill
pulseaudio --start
setsid -f emacs --daemon
setsid -f rescuetime
setsid -f redshift-gtk
setsid -f dunst
CM_SELECTIONS=clipboard setsid -f clipmenud
# setsid -f compton -b
# setsid -f qbittorrent-nox -d --webui-port=7890

i3blocks | ~/.config/dwm/status.py &


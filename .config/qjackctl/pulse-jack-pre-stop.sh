#!/bin/sh

LANG=C pactl list | \
    grep -B 1 'Name: module-jack-sink' | \
    sed -n '/Module/ s/[^0-9]//g p' | \
    xargs -n1 pactl unload-module

LANG=C pactl list | \
    grep -B 1 'Name: module-jack-source' | \
    sed -n '/Module/ s/[^0-9]//g p' | \
    xargs -n1 pactl unload-module
sleep 5

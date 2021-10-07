#!/bin/sh

mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_STATE_HOME"

~/.config/asy/config_private.default.sh
~/.config/octave/octaverc.default.sh
~/.config/wget/wgetrc.default.sh

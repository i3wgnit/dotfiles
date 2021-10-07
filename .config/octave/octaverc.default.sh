#!/bin/sh

DIRNAME="$(dirname "$0")"

if [ -f "$DIRNAME"/octaverc ] ; then
    echo "$DIRNAME"/octaverc already exists
else
    cat >"$DIRNAME"/octaverc <<EOF
source /usr/share/octave/site/m/startup/octaverc;
pkg prefix ${XDG_DATA_HOME}/octave/packages ${XDG_DATA_HOME}/octave/packages;
pkg local_list ${XDG_DATA_HOME}/octave/octave_packages;
EOF
fi

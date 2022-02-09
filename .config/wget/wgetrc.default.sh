#!/bin/sh

DIRNAME="$(dirname "$0")"

if [ -f "$DIRNAME"/wgetrc ] ; then
    echo "$DIRNAME"/wgetrc already exists
else
    cat >"$DIRNAME"/wgetrc <<EOF
hsts-file = ${XDG_STATE_HOME}/wget_history
EOF
fi

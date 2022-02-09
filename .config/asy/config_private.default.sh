#!/bin/sh

DIRNAME="$(dirname "$0")"

if [ -f "$DIRNAME"/config_private.asy ] ; then
    echo "$DIRNAME"/config_private.asy already exists
else
    cat >"$DIRNAME"/config_private.asy <<EOF
string asy_home="${XDG_CONFIG_HOME}/asy";
EOF
fi

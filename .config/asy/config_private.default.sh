#!/bin/sh

DIRNAME="$(dirname "$0")"

[ -f "$DIRNAME"/config_private.asy ] ||\
    tee "$DIRNAME"/config_private.asy >/dev/null <<EOF
string asy_home="${XDG_CONFIG_HOME}/asy";
EOF

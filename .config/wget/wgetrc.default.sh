#!/bin/sh

DIRNAME="$(dirname "$0")"

tee "$DIRNAME"/wgetrc >/dev/null <<EOF
hsts-file = ${XDG_DATA_HOME}/wget/wget-hsts
EOF

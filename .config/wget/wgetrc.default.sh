#!/bin/sh

DIRNAME="$(dirname "$0")"

if [ -f "$DIRNAME"/wgetrc ]; then
    echo "$DIRNAME"/wgetrc already exists
else
    tee "$DIRNAME"/wgetrc >/dev/null <<EOF
hsts-file = ${XDG_DATA_HOME}/wget/wget-hsts
EOF
fi

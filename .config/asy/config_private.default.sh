#!/bin/sh

[ -f 'asy/config_private.asy' ] ||\
    tee asy/config_private.asy <<EOF
string asy_home="${HOME}/.config/asy";
EOF

#!/bin/sh

# asy_home="/path/to/.asy";
[ -f 'asy/config_private.asy' ] ||\
    cat <<EOF >asy/config_private.asy
string asy_home="${HOME}/.config/asy";
EOF

#!/bin/sh

# asy_home="/path/to/.asy";
cat <<EOF >asy/config_private.asy
string asy_home="${HOME}";
EOF

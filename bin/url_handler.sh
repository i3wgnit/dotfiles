#!/bin/bash

echo "$1" | xclip -selection c -in
notify-send "Copied Url:" "$1"

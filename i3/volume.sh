#!/bin/bash

updateVolume='pkill -RTMIN+10 i3blocks'

case ${1} in
    up)         pamixer --allow-boost -ui $2; $updateVolume ;;
    down)       pamixer --allow-boost -ud $2; $updateVolume ;;
    mute)       pamixer -t; $updateVolume ;;
    truemute)   pamixer -m; $updateVolume ;;
esac


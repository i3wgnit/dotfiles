#!/bin/sh

if pactl info >/dev/null 2>&1 ; then
    killall pipewire
fi

pipewire >/dev/null 2>&1 &
until pactl info >/dev/null 2>&1 ; do
    sleep 1
done

pactl set-default-source "$(pactl get-default-source)"

pw-cli create-node adapter factory.name='support.null-audio-sink' media.class='Audio/Duplex' object.linger='true' node.name='loopback_mic' node.description='Loopback_Mic'

pactl load-module module-loopback source_dont_move='true' source='loopback_out.monitor'
pactl load-module module-loopback sink_dont_move='true' source_dont_move='true' sink='loopback_mic'
pw-link loopback_out:monitor_FL loopback_mic:playback_1
pw-link loopback_out:monitor_FR loopback_mic:playback_2

pw-metadata 0 default.configured.audio.source '{ "name": "loopback_mic" }'
#!/bin/sh

SINK="$(pactl get-default-source)"

pw-cli create-node adapter factory.name='support.null-audio-sink' media.class='Audio/Sink' object.linger='true' monitor.channel-volumes='true' node.name='loopback_out' node.description='Loopback_Out'
pw-cli create-node adapter factory.name='support.null-audio-sink' media.class='Audio/Duplex' object.linger='true' node.name='loopback_mic' node.description='Loopback_Mic'
pactl set-default-source loopback_mic

pactl load-module module-loopback source_dont_move='true' source='loopback_out.monitor'
pactl load-module module-loopback sink_dont_move='true' source="$SINK" sink='loopback_mic'

pw-link loopback_out:monitor_1 loopback_mic:playback_1
pw-link loopback_out:monitor_2 loopback_mic:playback_2

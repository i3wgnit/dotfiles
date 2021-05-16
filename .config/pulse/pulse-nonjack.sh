#!/bin/sh

pactl unload-module module-loopback
pactl unload-module module-null-sink

pactl load-module module-null-sink sink_name=duplex_out sink_properties=device.description="Duplex_Output"
pactl load-module module-null-sink sink_name=loopback_out sink_properties=device.description="Loopback_Output"
pactl load-module module-loopback source=loopback_out.monitor
pactl load-module module-loopback source=loopback_out.monitor sink=duplex_out
pactl load-module module-loopback source="$(pactl list short sources | grep 'alsa_input' | cut -f 1)" sink=duplex_out
pactl set-default-source duplex_out.monitor

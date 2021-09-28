#!/bin/sh

pactl unload-module module-remap-source
pactl unload-module module-loopback
pactl unload-module module-null-sink

pactl set-default-source "$(pactl get-default-source)"

pactl load-module module-null-sink sink_name=duplex_out sink_properties=device.description="Ignore_Me_Output"
pactl load-module module-null-sink sink_name=loopback_out sink_properties=device.description="Loopback_Output"

pactl load-module module-loopback source_dont_move=true source=loopback_out.monitor
pactl load-module module-loopback sink_dont_move=true source_dont_move=true source=loopback_out.monitor sink=duplex_out
pactl load-module module-loopback sink_dont_move=true source_dont_move=true sink=duplex_out

pactl load-module module-remap-source source_name=loopback_mic master=duplex_out.monitor source_properties=device.description="Loopback_Input"
pactl set-default-source loopback_mic

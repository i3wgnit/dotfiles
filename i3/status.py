#!/usr/bin/python

from i3pystatus import Status
from i3pystatus.weather import weathercom

status = Status(logfile='$HOME/var/i3pystatus.log')

status.register("clock",
        format="{}  %A %B %d %H:%M:%S".format("　")
#         on_leftclick=['scroll_format', 1]
        )

# status.register("backlight",
#         backlight="intel_backlight",
#         format="　  {percentage}%",
#         interval=3)

status.register("alsa",
        format="{muted}　  {volume}%",
        muted="",
        unmuted="",
        on_upscroll=[],
        on_downscroll=[])

status.register("battery",
        format="{status}　  {percentage:.2f}%[ {percentage_design:.0f}%][ {remaining:%E%h:%M}]",
        alert=True,
        alert_percentage=10,
        alert_format_body="{percentage:.2f}% ({remaining:%E%hh:%Mm}) remaining!",
        status={
            'FULL': '',
            'DPL': '',
            'CHR': '',
            'DIS': ''
        },
        interval=15)

status.register("network",
        dynamic_color=False,
        color_up="#FFFFFF",
        color_down="#FFFFFF",
        interface="wlp2s0",
        format_up="　  {v4} {kbs}KB/s {quality}%",
        format_down="　  {interface}: DOWN",
        interval=1)

status.register("disk",
        path="/",
        format="　  {used}/{total}G [{avail}G]",
        interval=30)

status.register("weather",
        format="{icon}  {condition}, {current_temp}{temp_unit}[ HI: {high_temp}][ LO: {low_temp}][{update_error}]",
        color="#FFFFFF",
        hints={'markup': 'pango'},
        backend=weathercom.Weathercom(
            location_code="CAXX2463:1:CA",
            units="metric",
        ),
        on_leftclick=["check_weather"],
        on_doubleleftclick=["launch_web"],
        interval=1800)

# status.register("window_title",
#         format="{title}",
#         max_width=45)

status.run()

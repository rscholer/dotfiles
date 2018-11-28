#!/bin/env python
# Copyright (c) 2018 Raphael Scholer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
"""Configuration for i3pystatus."""
import i3pystatus
import i3pystatus.updates.auracle
import i3pystatus.updates.pacman


COLOR_DEFAULT = None
COLOR_DISABLED = '#afb8c5'
COLOR_INFORMATION = '#cc575d'


status = i3pystatus.Status(standalone=True, click_events=True)

status.register(
    'clock',
    color=COLOR_DEFAULT,
    format='%Y-%m-%d %H:%M',
)
status.register(
    'pulseaudio',
    color_muted=COLOR_DISABLED,
    color_unmuted=COLOR_DEFAULT,
    format='\uf028 {volume}%',  # fa-volume-up
    format_muted='\uf026 {volume}%',  # fa-volume-off
    on_leftclick='switch_mute',
    on_rightclick='pavucontrol',
    sink='@DEFAULT_SINK@',
)
status.register(
    'network',
    color_down=COLOR_DISABLED,
    color_up=COLOR_DEFAULT,
    detect_active=True,
    dynamic_color=False,
    format_active_up={
        'e*': '\uf6ff',  # fa-network-wired
        'w*': '\uf1eb {essid}',  # fa-wifi
    },
    format_down='\uf110',  # fa-spinner
)
status.register(
    'scratchpad',
    always_show=False,
    color=COLOR_DEFAULT,
    color_urgent=COLOR_INFORMATION,
    format='\uf2d0 {number}',  # fa-window-maximize
)
status.register(
    'cmus',
    color=COLOR_DEFAULT,
    format=(
        '{status}'
        '[ {artist} - {title} - {album}]'
        '[ ({song_elapsed:%M:%S}/{song_length:%M:%S})]'
    ),
    format_not_running='',
    status={
        'paused': '\uf04c ',  # fa-pause
        'playing': '\uf04b ',  # fa-play
        'stopped': '\uf04d',  # fa-stop
    },
)
status.register(
    'updates',
    backends=[
         i3pystatus.updates.auracle.Auracle(),
         i3pystatus.updates.pacman.Pacman(),
    ],
    color=COLOR_INFORMATION,
    format='\uf071 {Pacman}[+{Auracle}]',  # fa-exclamation-triangle
    format_no_updates='',
    format_working='',
    interval=10 * 60,
)

status.run()

#!/bin/bash
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

# Load system-wide xinitrc configurations.
if [[ -d "/etc/X11/xinit/xinitrc.d" ]]; then
	for file in '/etc/X11/xinit/xinitrc.d'/*.sh; do
		if [[ -x "${file}" ]]; then
			source "${file}"
		fi
	done

	unset file
fi

# Setup environment for X sessions.
if [[ -f  "${HOME}/.xprofile" ]]; then
	source "${HOME}/.xprofile"
fi

# Merge user Xdefaults.
if [[ -f "${HOME}/.Xresources" ]] && which xrdb >/dev/null 2>&1; then
	xrdb -merge -I"${HOME}" "${HOME}/.Xresources" &
fi

# Load keyboard tweaks.
if [[ -f "${HOME}/.Xmodmap" ]] && which xmodmap >/dev/null 2>&1; then
	xmodmap "${HOME}/.Xmodmap" &
fi

# Load session specific commands.
if [[ -f "${HOME}/.xsession" ]]; then
	source "${HOME}/.xsession"
fi

# Start window manager / desktop environment.
exec i3

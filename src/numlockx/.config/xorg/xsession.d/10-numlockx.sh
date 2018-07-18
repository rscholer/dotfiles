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

# Enable/disable numlock.

if which numlockx >/dev/null 2>&1; then
	if  [[ -f "${XDG_DATA_HOME:-${HOME}/.local/share}/numlock_on" ]]; then
		numlockx on &
	elif  [[ -f "${XDG_DATA_HOME:-${HOME}/.local/share}/numlock_off" ]]; then
		numlockx off &
	elif [[ -d "/sys/class/power_supply/BAT0" ]]; then
		# Disable numlock except when a external keyboard is connected,
		if [[ $(find "/dev/input/by-path" -type l -name "*-kbd" | wc -l) -gt 1 ]]; then
			numlockx on &
		else
			numlockx off &
		fi
	else
		numlockx on &
	fi
fi

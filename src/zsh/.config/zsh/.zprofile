#!/bin/zsh
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

# This script is run when Zsh is invoked as a login shell.
#
# Important: This file is loaded before "${ZDOTDIR}/.zshrc". If you want to run
#            things in a login shell after "${ZDOTDIR}/.zshrc" is loaded use
#            "${ZDOTDIR}/.zlogin".

# Clear screen.
[[ -z "${SSH_TTY}" && -f "${HOME}/.hushlogin" ]] && clear

# Make sure '~/.profile' is always loaded.
[[ -r "${HOME}/.profile" ]] && emulate sh -c "source ${HOME}/.profile"

# Autostart X session.
if [[ -z "${SSH_TTY}" && "${XDG_VTNR}" -eq 1 && "${EUID}" -ne 0 ]]; then
	if [[ -n ${commands[startx]} && -f "${HOME}/.xinitrc" ]]; then
		if systemctl list-units --type target |grep -q graphical; then
			[[ -z ${DISPLAY} ]] && exec startx -- -keeptty >|/dev/null 2>&1
		fi
	fi
fi

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

# Set path for startup
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-${HOME}/.config}/python.py"

# Set path for virtualenvwrapper
export WORKON_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/virtualenvs"

# Set path to Python documentation
if [[ -z ${PYTHONDOCS} ]]; then
	if [[ -d "${XDG_PUBLICSHARE_DIR:-${HOME}/Public/python-docs}" ]]; then
		export PYTHONDOCS="${XDG_PUBLICSHARE_DIR:-${HOME}/Public/python-docs}"
	fi
fi

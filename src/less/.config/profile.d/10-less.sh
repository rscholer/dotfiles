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

# Set path for the history file
export LESSHISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/less_history"

# Settings for less
# -F = Automatically exit if entire file can be displayed on the first screen
# -J = Display a status column.
# -M = More verbose prompt.
# -Ph = Prompt for the help screen.
# -R = Display "raw" control characters.
# -g = Highlight search string.
# -i = Ignore cases when searching.
# -s = Fold consecutive blank lines into a single line.
# -z = Set window scrolling size.
# -~ = Don't use '~' to indicate lines after the end of a file.
LESS='-J -M '
LESS+='-PhHELP ?ltlines %-R -g -i -s -z-4 -~lt-%lb?L/%L. ?e(END):?pB(%pB\%)..%t$ '
LESS+='-R -g -i -s -z-4 -~'
export LESS

# Colorize man when using less as pager
export LESS_TERMCAP_mb=$'\E[01;31m'        # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;38;5;74m'   # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'            # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'            # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[38;5;246m'     # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'            # Ends underline.
export LESS_TERMCAP_us=$'\E[04;38;5;146m'  # Begins underline.

# Load lespipe, which provides advanced functionality for less
which lesspipe >/dev/null 2>&1 && eval "$(lesspipe)"
which lesspipe.sh >/dev/null 2>&1 && eval "$(lesspipe.sh)"

# Set less as the default pager
export MANPAGER='less'
export PAGER='less'
export READNULLCMD='less'

# Use a nice textwidth for man pages
export MANWIDTH='80'

# Set a much nicer prompt for manpage display with less
MANLESS='Manual page \$MAN_PN ?ltlines %lt-%lb?%L/%L.:'
MANLESS+='byte %bB?s/%s.. '
MANLESS+='?e(END):?pB%pB\%..%t$'
export MANLESS

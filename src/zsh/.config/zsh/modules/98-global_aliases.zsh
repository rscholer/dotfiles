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

# Set global aliases.

# grep aliases
if [[ ${commands[grep]} ]]; then
	alias -g G='|grep'
	alias -g GI='|grep -i'
	alias -g GIV='|grep -iv'
	alias -g GV='|grep -v'
fi

# Misc.
alias -g C='|wc -l'
alias -g F='&>|/dev/null &|'
[[ -n ${functions[keep]} ]] && alias -g K='|keep'

# Paging
alias -g H='|head'
alias -g P="|${PAGER}"
alias -g T='|tail'

# Sorting
alias -g S='|sort'
alias -g SN='|sort --numeric-sort'
alias -g U='|uniq'

# stderr, stdout handling
alias -g ES='2>&1'
alias -g NE='2>|/dev/null'
alias -g NO='&>|/dev/null'

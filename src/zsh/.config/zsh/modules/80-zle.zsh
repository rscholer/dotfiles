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

function zle-line-finish() {
	# Run code when ZLE finishes.
	emulate -L zsh

	[[ -n ${terminfo[rmkx]} ]] && echoti rmkx
}

function zle-line-init() {
	# Run code when ZLE is initialized.
	emulate -L zsh

	[[ -n ${terminfo[smkx]} ]] && echoti smkx
}

# Enable ZLE widgets.
zle -N 'hide-from-history'
zle -N 'insert-iso-date'
zle -N 'self-insert' 'url-quote-magic'
zle -N 'toggle-sudo'
zle -N 'zle-line-finish' 'zle-line-finish'
zle -N 'zle-line-init' 'zle-line-init'

# Set emacs mode.
bindkey -e

# Don't recognize '/' as part of a word.
WORDCHARS="${WORDCHARS/\/}"

() {
	local key

	typeset -A key

	key=(
		# Key           terminfo code
		'BackSpace'     "${terminfo[kbs]}"
		'Delete'        "${terminfo[kdch1]}"
		'Down'          "${terminfo[kcud1]}"
		'End'           "${terminfo[kend]}"
		'Home'          "${terminfo[khome]}"
		'Insert'        "${terminfo[kich1]}"
		'Left'          "${terminfo[kcub1]}"
		'PageDown'      "${terminfo[knp]}"
		'PageUp'        "${terminfo[kpp]}"
		'Right'         "${terminfo[kcuf1]}"
		'ShiftLeft'     "${terminfo[kLFT]}"
		'ShiftRight'    "${terminfo[kRIT]}"
		'Up'            "${terminfo[kcuu1]}"
	)

	bindkey "${key[BackSpace]}"     'backward-delete-char'
	bindkey "${key[Delete]}"        'delete-char'
	bindkey "${key[Down]}"          'history-beginning-search-forward'
	bindkey "${key[End]}"           'end-of-line'
	bindkey "${key[Home]}"          'beginning-of-line'
	bindkey "${key[Insert]}"        'overwrite-mode'
	bindkey "${key[PageDown]}"      'history-beginning-search-forward'
	bindkey "${key[PageUp]}"        'history-beginning-search-backward'
	bindkey "${key[ShiftLeft]}"     'backward-word'
	bindkey "${key[ShiftRight]}"    'forward-word'
	bindkey "${key[Up]}"            'history-beginning-search-backward'

	bindkey '^ '                    'magic-space'
	bindkey '^Xd'                   'insert-iso-date'
	bindkey '^Xh'                   'run-help'
	bindkey '^Xk'                   'insert-kept-result'
	bindkey '^Xs'                   'toggle-sudo'
	bindkey '^X '                   'hide-from-history'

	# Set keybindings for menu selection.
	bindkey -M menuselect 'i' accept-and-menu-complete
}

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

# Set regular aliases.

# Allow sudo to use aliases.
[[ -n ${commands[sudo]} ]] && alias sudo='sudo '

# Filesystem utilities.
alias chgrp='chgrp --changes --preserve-root'
alias chmod='chmod --changes --preserve-root'
alias chown='chown --changes --preserve-root'
alias cp='cp --interactive --verbose'
alias dd='dd status=progress'
alias df='df --human-readable'
alias dfp='df --exclude-type=devtmpfs --exclude-type=tmpfs'
alias du='du --human-readable'
alias la='ls --almost-all'
alias ll='ls --format=long'
alias lla='ls --almost-all --format=long'
alias ln='ln --interactive --verbose'
alias ls='ls --classify --color --group-directories-first --human-readable'
alias ls="${aliases[ls]} --literal --time-style=long-iso"
alias mkdir='mkdir --parents --verbose'
alias mount='mount --verbose'
alias mv='mv --interactive --verbose'
alias rm='rm --preserve-root --verbose'
alias rmdir='rmdir --verbose'
alias umount='umount --verbose'

if [[ -n ${commands[rsync]} ]]; then
	alias rsync='rsync --compress --human-readable --verbose'
fi
if [[ -n ${commands[udiskie]} ]]; then
	alias udiskie-mount='udiskie-mount --recursive'
	alias udiskie-umount='udiskie-umount --lock'
fi
[[ -n ${commands[unison]} ]] && alias unison='unison -ui text'

# git related programs
[[ -n ${commands[tig]} ]] && alias tig='tig --show-signature'

# grep-like programs
[[ -n ${commands[grep]} ]] && alias grep='grep --color'
[[ -n ${commands[pgrep]} ]] && alias pgrep='pgrep --list-name'

# Package management.
[[ -n ${commands[auracle]} ]] && alias auracle='noglob auracle --recurse'
[[ -n ${commands[makepkg]} ]] && alias makepkg="makepkg --cleanbuild --nocheck"
[[ -n ${commands[paccache]} ]] && alias paccache='paccache --verbose'
[[ -n ${commands[pkgfile]} ]] && alias pkgfile='pkgfile --verbose'

# Pager
[[ -n ${commands[info]} ]] && alias info='info --vi-keys'
if [[ -n ${functions[prompt_lines_free]} ]]; then
	alias head='head -n $(prompt_lines_free)'
	alias tail='tail -n $(prompt_lines_free)'
fi

# Process management.
[[ -n ${commands[free]} ]] && alias free='free --mega --human --total'
[[ -n ${commands[htop]} ]] && alias uhtop="htop -u ${USERNAME}"
[[ -n ${commands[top]} ]] && alias utop="top -u ${USERNAME}"

# Network management
[[ -n ${commands[curl]} ]] && alias ipe='curl ipinfo.io/ip'
[[ -n ${commands[ip]} ]] && alias ip='ip -color -human-readable -iec'
[[ -n ${commands[iwmon]} ]] && alias iwmon='iwon --nortnl'
[[ -n ${commands[ping4]} ]] && alias ping4='ping4 -c4'
[[ -n ${commands[ping6]} ]] && alias ping6='ping6 -c4'
[[ -n ${commands[ping]} ]] && alias ping='ping -c4'

# Misc programs
[[ -n ${commands[colordiff]} ]] && alias diff='colordiff'
alias modprobe='modprobe --verbose'
[[ -n ${commands[ffmpeg]} ]] && alias ffmpeg='ffmpeg -hide_banner'
if [[ -n ${commands[filename_stem2md5]} ]]; then
	alias filename_stem2md5='filename_stem2md5 --verbose'
fi
if [[ -n ${commands[inotifywait]} ]]; then
	alias inotifywait='inotifywait --quiet --timefmt="%F %T" --format="%T: %w: %e"'
fi
[[ -n ${commands[sxiv]} ]] && alias sxiv='sxiv -ar'
[[ -n ${commands[youtube-dl]} ]] && alias youtube-dl='noglob youtube-dl'
[[ -n ${commands[xclip]} ]] && alias xclip='xclip -selection clipboard'

# nice-like programs
alias ionice='ionice -c 3'
alias nice='nice -n 19'

# Zsh utilities
if [[ -n ${functions[zmv]} ]]; then
	alias zcp='zmv -C'
	alias zln='zmv - L'
	alias zmv='zmv -o --verbose'
fi

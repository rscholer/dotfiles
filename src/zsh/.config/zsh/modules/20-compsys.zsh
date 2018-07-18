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

# Configure completion system.

# Enable caching.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${ZCACHEDIR}/zcompcache"

# Automatically rehash.
zstyle ':completion:*' rehash true

# Always generate matches in a verbose form.
zstyle ':completion:*' verbose yes

# Always turn on menu selection.
zstyle ':completion:*' menu select=1 yes

# Display all types of matches separately.
zstyle ':completion:*' group-name ''

# Allow completion for '..'
zstyle ':completion:*' special-dirs '..'

# Always list directories furst, as an extra group.
zstyle ':completion:*' list-dirs-first yes

# Style headers.
zstyle ':completion:*:corrections' format "%B%U%F{green}%d (errors: %e)%f%u%b"
zstyle ':completion:*:default' select-prompt "%B%F{black}Match %M%P%f%b"
zstyle ':completion:*:descriptions' format "%B%U%F{green}%d%f%u%b"
zstyle ':completion:*:messages' format "%B%U%F{yellow}%d%f%u%b%"
zstyle ':completion:*:warnings' format "%B%F{red}No matches for: %d%f%b"

# Use $LS_COLORS for file listings
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Setup completion for man pages.
zstyle ':completion:*:man:*' menu yes select
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Change group/tag order
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' \
                                             'path-directories' \
                                             'users' \
                                             'expand'

# Provide process information.
zstyle ':completion:*:processes' command \
	'ps -u ${USERNAME} -o pid,user,cmd -w -w'
zstyle ':completion:*:processes' list-colors \
	'=(#b) #([0-9]#) ([0-9a-z]#)*=0=01;36=01'
zstyle ':completion:*:processes-names' command \
	'ps --no-headers -u ${USERNAME} -o cmd -w -w'

# General ignoring of patterns (not application specific).
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:users' ignored-patterns '_*' \
	$(awk -F: '{if (($3 > 0 && $3 < 1000) || $7 ~ "nologin$") print $1}' /etc/passwd) \
	$(setopt EXTENDED_GLOB; print /run/systemd/dynamic-uid/direct:^[0-9]*(@N:t:s/direct:/))

# Add completion for wrappers.
compdef _diff colordiff
[[ "${commands[vi]:P:t}" == *'vim' ]] && compdef _vim vi

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

# Configure vcs_info.
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz vcs_info_hookadd

# Settings for vcs_info.
zstyle ':vcs_info:*' actionformats '%s:%b%u%c|%a' '%m'
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%s:%b%u%c' '%m'
zstyle ':vcs_info:*' max-exports 2
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' untrackedstr '?'
zstyle ':vcs_info:*' use-simple false
zstyle ':vcs_info:git*' check-for-changes true

# Enable vcs_info hooks
vcs_info_hookadd 'set-message' 'set-message-git-ahead_behind'
vcs_info_hookadd 'set-message' 'set-message-git-remotebranch'
vcs_info_hookadd 'set-message' 'set-message-git-untracked'

# Add vcs_info to hooks
add-zsh-hook 'precmd' 'vcs_info'

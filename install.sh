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

function _chmod() {
	local permission
	local path

	path="${2}"
	permissions="${1}"

	if [[ -e "${path}" ]]; then
		chmod --changes "${permissions}" "${path}"
	fi
}

DIRECTORIES=(
	"${HOME}/.config/profile.d"
	"${HOME}/.config/systemd/user"
	"${HOME}/.gnupg"
	"${HOME}/.ssh"
)

PACKAGES=(
	'colorgcc'
	'git'
	'gnupg'
	'htop'
	'less'
	'pacman'
	'shells'
	'ssh'
	'tmux'
)

# Create needed directories.
mkdir --verbose --parents ${DIRECTORIES[*]}

# Install packages.
stow --restow --dir="./src" --target "${HOME}" ${PACKAGES[*]}

# Fix permissions.
_chmod 444 "${HOME}/.config/htop/htoprc"
_chmod 700 "${HOME}/.gnupg"
_chmod 700 "${HOME}/.ssh"

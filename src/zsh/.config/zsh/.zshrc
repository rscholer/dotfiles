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

# Setup for interactive zsh sessions.
# IMPORTANT: Avoid any output, except in cases of errors.

# Create needed directories.
mkdir --parents "${ZCACHEDIR}"

# Tie scalars to arrays (like $PATH to $path).
export -TU GLADE_CATALOG_PATH glade_catalog_path
export -TU GLADE_MODULE_PATH glade_module_path
export -TU GLADE_PIXMAP_PATH glade_pixmap_path
export -TU LD_LIBRARY_PATH ld_library_path
export -TU PYTHONPATH pythonpath
export -TU XDG_CONFIG_DIRS xdg_config_dirs
export -TU XDG_DATA_DIRS xdg_data_dirs

# Add directories to fpath.
fpath=("${ZDATADIR}/functions"/**/*(FN) ${fpath})

# Configure history
export HISTFILE="${ZCACHEDIR}/history"
export SAVEHIST=10000
export HISTSIZE=12500

# Load completion system functions.
zmodload 'zsh/complist'

# Autoload functions.
() {
	local func
	local funcdir

	for funcdir in ${fpath}; do
		for func in "${funcdir}"/**/*(.,@N:t); do
			autoload -Uz -- "${func}"

			case "${func}" in
				compinit )
					compinit -d "${ZCACHEDIR}/zcompdump"
					;;
				hash_directories )
					hash_directories
					;;
				keeper )
					keeper
					;;
			esac
		done
	done
}

# Load configuration modules.
() {
	local file

	for file in "${ZDOTDIR}/modules"/*.zsh(N); do
		source "${file}"
	done
}

# Set up prompt.
() {
	# Enable prompt system
	promptinit

	# Set prompt
	prompt 'simple'

	# Disable end-of-line mark
	PROMPT_EOL_MARK=''

	# Setup misc. prompts.
	SPROMPT='Correct "%B%F{red}%R%b%f" to "%B%F{green}%r%f%b"?'
	SPROMPT+=' ([yes]/%B%F{white}[N]o%f%b/[e]dit/[a]bort) '

	# Fix output when starting a pipenv shell.
	if [[ -n ${PIPENV_ACTIVE} && "${prompt_theme}" == 'simple' ]]; then
		print
	fi
}

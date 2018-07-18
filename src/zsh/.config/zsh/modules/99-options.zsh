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

# Set options for interactive sessions.

# Changing Directories
setopt 'AUTO_CD'               # Unknown commands are treated as 'cd command'.
setopt 'AUTO_PUSHD'            # cd pushes old directory onto stack.
setopt 'CDABLE_VARS'           # Handle unknown expressions like they start
                               # with a '~'.
setopt 'NO_CHASE_DOTS'         # Resolve path to physical directory when
                               # using '..'.
setopt 'PUSHD_IGNORE_DUPS'     # Don't push duplicates onto the stack.
setopt 'PUSHD_MINUS'           # Exchanges the meanings of '+' and '-' when
                               # used to specify a directory in the stack.
setopt 'PUSHD_SILENT'          # Do not print the directory stack after
                               # 'pushd' and 'popd'.
setopt 'PUSHD_TO_HOME'         # Have 'pushd' with no arguments act like
                               # 'pushd $HOME'.

# Completion
setopt 'AUTO_LIST'             # Automatically list choices on an ambigous
                               # completion.
setopt 'COMPLETE_IN_WORD'      # Complete inside of words.
setopt 'GLOB_COMPLETE'         # Don't insert all matches of pattern,
                               # show a menu.
setopt 'HASH_LIST_ALL'         # Always hash entire command paths.
setopt 'LIST_PACKED'           # Make completion list smaller, but uglier.


# Expansion and Globbing
setopt 'BRACE_CCL'             # Advanced expansion in brackets.
setopt 'EXTENDED_GLOB'         # '#', '~' and '^' are part of globbing
                               # patterns.
setopt 'MARK_DIRS'             # Append a trailing '/' to all directory names
                               # resulting from globbing.


# History
setopt 'EXTENDED_HISTORY'      # Save each command's timestamp.
setopt 'HIST_FCNTL_LOCK'       # Use 'fcntl' syscall for locking files.
setopt 'HIST_IGNORE_ALL_DUPS'  # Remove old duplicates of a command.
setopt 'HIST_IGNORE_SPACE'     # Don't save lines prefixed with whitespace.
setopt 'HIST_NO_STORE'         # Don't save 'history' and 'fc -l' commands.
setopt 'HIST_REDUCE_BLANKS'    # Remove superfluous whitespace from commands.
setopt 'HIST_VERIFY'           # Don't execute history expansion automatically.
setopt 'INC_APPEND_HISTORY'    # Save new commands incrementally.
setopt 'SHARE_HISTORY'         # Share history between all Zsh sessions.


# Jobs
setopt 'BG_NICE'               # Run background jobs at lower priority.
setopt 'NO_NOTIFY'             # Don't report status of background jobs
                               # immediately.

# Input/Output
setopt 'HASH_CMDS'             # Hash location of each command.
setopt 'HASH_DIRS'             # Hash all directories in path of command.
setopt 'INTERACTIVE_COMMENTS'  # Honor comments in interactive mode.
setopt 'NO_CLOBBER'            # Secure pipe handling.
setopt 'NO_CORRECT'            # Correct spelling of commands.
setopt 'NO_CORRECT_ALL'        # Correct spelling of arguments.
setopt 'RM_STAR_WAIT'          # Wait 10 secs, when issuing e.g. 'rm *'.
setopt 'SHORT_LOOPS'           # Allow the short forms of loop constructs.

# Prompting
setopt 'TRANSIENT_RPROMPT'     # Hide RPROMPT when the current command is
                               # too long.

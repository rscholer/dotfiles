#!/bin/env python3
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
"""This file will be executed when running python as a shell."""
import atexit
from importlib import reload  # noqa: Make testing of code easier.
import json  # noqa: Make testing of code easier.
import os
import pathlib
import re  # noqa: Make testing of code easier.
import readline
import rlcompleter  # noqa: Needs to be imported for enabling tab-completion.
import sys
from typing import Any
from typing import List
from typing import Optional


def ansi_colorize(text: str, color: str, state: Optional[List[str]] = None,
                  prompt: bool = False) -> str:
    """Add ANSI color escape sequences to a text.

    This function also adds some extra escape sequences, so that Readline will
    be able to accurately determine the length of the modified text.

    Parameters
    ----------
    text :
        Text to colorize.
    color :
        Color to be used: `black`, `blue`, `cyan`, `green`, `purple`, `red`,
                          `white` or `yellow`.
    state :
        List of states: `bold`, `bright`, `regular` or `bright`.
        (Default: ['regular'])

    Returns
    -------
    str :
        Modified text.

    """
    ansi_colors = {
        'black': 30,
        'red': 31,
        'green': 32,
        'yellow': 33,
        'blue': 34,
        'purple': 35,
        'cyan': 36,
        'white': 37,
    }
    states = {
        'bright': '0;',
        'regular': '0;',
        'bold': '1;',
        'underline': '4;',
    }

    state = state or ['regular']
    color_offset = 60 if 'bright' in state else 0

    col = ansi_colors[color] + color_offset
    mod = ''.join([states[x] for x in state])

    if prompt:
        return f'\001\033[{mod}{col}m\002{text}\001\033[00m\002'
    else:
        return f'\033{mod}{col}m{text}\033[00m'


def displayhook_pprint(value: Any) -> None:
    """Use pprint.pprint to display values.

    Parameters
    ----------
    value :
        Value to display.

    Returns
    -------
    None

    """
    import pprint
    import builtins

    if value is None:
        return

    pprint.pprint(value)
    builtins._ = value  # type: ignore


if __name__ == '__main__':
    ################################
    # History
    ################################
    histfile = (
        pathlib.Path(os.getenv('XDG_CONFIG_HOME', '~/.cache')).expanduser() /
        f'python{sys.version_info.major}_history'
    )

    # Constrict history size
    readline.set_history_length(1000)

    # Create custom history file
    histfile.parent.mkdir(parents=True, exist_ok=True)
    histfile.touch(mode=0o600, exist_ok=True)

    # Load custom history file
    if histfile.exists():
        readline.read_history_file(histfile)  # type: ignore

    # Use custom history file
    atexit.register(readline.write_history_file, histfile)

    ################################
    # Keybindings
    ################################
    # Enable tab completion
    readline.parse_and_bind('tab: complete')

    ###############################
    # Prompt
    ###############################
    sys.ps1 = ansi_colorize('>>>', color='blue', state=['bold'], prompt=True) + ' '
    sys.ps2 = ansi_colorize('...', color='yellow', state=['bold'], prompt=True) + ' '

    ################################
    # Use pprint to print variables.
    ################################
    sys.displayhook = displayhook_pprint

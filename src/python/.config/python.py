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
from importlib import reload # noqa
import json  # noqa
import math  # noqa
import os
from pprint import pprint  # noqa
import re  # noqa
import readline
import rlcompleter  # noqa: Needs to be imported for enabling tab-completion.
import sys
from typing import Any
from typing import Callable


CUSTOM_HISTFILE = os.path.expanduser(
    os.path.join(
        os.getenv('XDG_CACHE_HOME', '~/.cache'),
        'python{}_history'.format(sys.version_info.major)
    )
)

DEFAULT_HISTFILE = os.path.expanduser('~/.python_history')

HISTSIZE = 1000


def colorize_prompt(text: str, color: str, state: str) -> str:
    """Colorize prompt.

    Parameters
    ----------
    text :
        Text to colorize.
    color :
        Color to be used: `black`, `blue`, `cyan`, `green`, `purple`, `red`,
                          `white` or `yellow`.
    state :
        State: `bold`, `bright`, `regular` or `bright`.

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
        'regular': '0;',
        'bold': '1;',
        'underline': '4;',
    }

    col = ansi_colors.get(color)
    mod = states.get(state, '')

    if col is None:
        col = 0
        mod = ''
    elif state == 'bright':
        col += 60
        mod = '0;'

    return '\001\033[{}{}m\002{}\001\033[00m\002'.format(mod, col, text)


def displayhook_pprint(value: Any, show: Callable = pprint) -> None:
    """Use pprint.pprint to display values.

    Parameters
    ----------
    value :
        Value to display.
    show : Callable
        Function used to display value.
        This argument is only used to make sure it's default value is always available.

    Returns
    -------
    None

    """
    if value:
        __builtins__._ = value
        show(value)


def load_history(fp: str) -> None:
    """Load history from file.

    Parameters
    ----------
    fp :
        Path to file.

    Returns
    -------
    None

    """
    try:
        readline.read_history_file(fp)
    except IOError:
        pass


def main() -> None:
    """Main function.

    Returns
    -------
    None

    """
    # Enable tab completion
    readline.parse_and_bind('tab: complete')

    # Set prompt
    sys.ps1 = colorize_prompt('>>> ', 'blue', 'bold')
    sys.ps2 = colorize_prompt('... ', 'yellow', 'bold')

    # Constrict history size
    readline.set_history_length(HISTSIZE)

    # Create custom history file
    touch(CUSTOM_HISTFILE)

    # Load custom history file
    load_history(CUSTOM_HISTFILE)

    # Use custom history file
    atexit.register(readline.write_history_file, CUSTOM_HISTFILE)

    # Remove default history at exit
    atexit.register(remove_file, DEFAULT_HISTFILE)

    # Use pprint to print variables
    sys.displayhook = displayhook_pprint


def remove_file(fp: str) -> None:
    """Remove default history file.

    Parameters
    ----------
    fp :
        Path to file.

    Returns
    -------
    None

    """
    try:
        os.remove(fp)
    except OSError:
        pass


def touch(fp: str) -> None:
    """Touch file, and create it's path.

    Parameters
    ----------
    fp :
        Path to file.

    Returns
    -------
    None

    """
    if not os.path.exists(fp):
        try:
            os.makedirs(os.path.dirname(fp))
        except OSError:
            pass
        else:
            with open(fp, 'ab'):
                os.utime(fp)


if __name__ == '__main__':
    main()

    # Cleanup
    del (
        # constants
        CUSTOM_HISTFILE,
        DEFAULT_HISTFILE,
        HISTSIZE,

        # functions
        colorize_prompt,
        displayhook_pprint,
        load_history,
        remove_file,
        touch,

        # modules
        atexit,
        readline,
        rlcompleter,
    )

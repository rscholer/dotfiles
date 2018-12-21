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
from importlib import reload  # noqa: Imported for convenience.
import json  # noqa: Imported for convenience.
import os
import pathlib
import re  # noqa: Imported for convenience.
import readline
import rlcompleter  # noqa: Needs to be imported for enabling tab-completion.
import sys
from typing import Any
from typing import List
from typing import Optional


class CustomPrompt:
    """Create a colorized prompt and report actual prompt length."""

    def __init__(self, text: str, color: str, state: Optional[List[str]] = None) -> None:
        """Initialize object.

        Parameters
        ----------
        text :
            Text of prompt.
        color :
            Text color.
            Needs to be one of: `black`, `blue`, `cyan`, `green`, `purple`, `red`,
            `white` or `yellow`.
        state :
            List of states: `bold`, `bright`, `regular` or `bright`.
            If set to `None`, fall back to `bold`.

        Returns
        -------
        None

        """
        self.color = color
        self.state = state or ['bold']
        self.text = text

    def __len__(self) -> int:
        """Return actual length of the prompt.

        All ANSI color escape sequences will be ignored.

        Returns
        -------
        int :
            Adjusted length of prompt.

        """
        return len(self.text) + 1

    def __str__(self) -> str:
        """Add ANSI color escape sequences to a text.

        Returns
        -------
        str :
            Modified text.

        """
        return self.ansi_colorize(self.text, self.color, self.state) + ' '

    @staticmethod
    def ansi_colorize(text: str, color: str, state: Optional[List[str]] = None) -> str:
        """Add ANSI color escape sequences to a text.

        This method also adds some extra escape sequences, so that Readline will
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

        return f'\001\033[{mod}{col}m\002{text}\001\033[00m\002'


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
        pathlib.Path(os.getenv('XDG_CACHE_HOME', '~/.cache')).expanduser() /
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
    # Key bindings
    ################################
    # Enable tab completion
    readline.parse_and_bind('tab: complete')

    ###############################
    # Prompt
    ###############################
    sys.ps1 = CustomPrompt('>>>', 'blue')  # type: ignore
    sys.ps2 = CustomPrompt('...', 'yellow')  # type: ignore

    ################################
    # Use pprint to print variables.
    ################################
    sys.displayhook = displayhook_pprint

    ################################
    # Don't write bytecode in interactive mode.
    ################################
    sys.dont_write_bytecode = True

    ################################
    # Cleanup
    ################################
    del (
        # Modules
        atexit,
        readline,
        rlcompleter,

        # Type hints
        Any,
        List,
        Optional,

        # Variables
        histfile,

        # Classes
        CustomPrompt,

        # Functions
        displayhook_pprint,
    )

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
import contextlib
from importlib import reload  # noqa: Imported for convenience.
import json  # noqa: Imported for convenience.
import os
import pathlib
import re  # noqa: Imported for convenience.
import readline
import rlcompleter  # noqa: Needs to be imported for enabling tab-completion.
import sys
from typing import Any
from typing import Dict
from typing import List
from typing import Optional
from typing import Tuple


class CommonDirectories:
    """Commonly used directories.

    Attributes
    ----------
    HOME : pathlib.Path
        Home directory.
    XDG_CACHE_HOME : pathlib.Path
        User cache data.
    XDG_CONFIG_DIRS : List[pathlib.Path]
        Directories containing configuration data.
    XDG_CONFIG_HOME : pathlib.Path
        User configuration data.
    XDG_DATA_DIRS : List[pathlib.Path]
        Directories containing persistend data.
    XDG_DATA_HOME : pathlib.Path
        Persistent user data.
    XDG_DESKTOP_DIR : pathlib.Path
        Files found on the desktop.
    XDG_DOWNLOAD_DIR : pathlib.Path
        Downloaded files.
    XDG_MUSIC_DIR : pathlib.Path
        Music files.
    XDG_PICTURES_DIR : pathlib.Path
        Picture files.
    XDG_PUBLICSHARE_DIR : pathlib.Path
        Publicly shared files (e.g. over SAMBA).
    XDG_RUNTIME_DIR : pathlib.Path
        Runtime files.
    XDG_TEMPLATES_DIR : pathlib.Path
        File templates.
    XDG_VIDEOS_DIR : pathlib.Path
        Video files.

    """

    def __init__(self) -> None:
        """Initialize object."""
        self.HOME = pathlib.Path().home()

        # XDG Base directories
        self.XDG_CACHE_HOME = pathlib.Path(
            os.getenv('XDG_CACHE_HOME', self.HOME / '.cache')
        )
        self.XDG_CONFIG_HOME = pathlib.Path(
            os.getenv('XDG_CACHE_HOME', self.HOME / '.config')
        )
        self.XDG_DATA_HOME = pathlib.Path(
            os.getenv('XDG_DATA_HOME', self.HOME / '.local/share')
        )
        self.XDG_RUNTIME_DIR = pathlib.Path(os.environ['XDG_RUNTIME_DIR'])

        # XDG User directories
        self.XDG_DESKTOP_DIR = self.HOME
        self.XDG_DOCUMENTS_DIR = self.HOME
        self.XDG_DOWNLOAD_DIR = self.HOME
        self.XDG_MUSIC_DIR = self.HOME
        self.XDG_PICTURES_DIR = self.HOME
        self.XDG_PUBLICSHARE_DIR = self.HOME
        self.XDG_TEMPLATES_DIR = self.HOME
        self.XDG_VIDEOS_DIR = self.HOME

        with contextlib.suppress(OSError):
            config = re.sub(
                r'\$HOME', str(self.HOME),
                (self.XDG_CONFIG_HOME / 'user-dirs.dirs').read_text()
            )

            for name, path in re.findall(r'^\s*(\w*)="(.*)"\s*$', config, re.MULTILINE):
                self.__setattr__(name, pathlib.Path(path))

        # XDG additional directories
        self.XDG_CONFIG_DIRS = os.getenv('XDG_CONFIG_HOME', '/etc/xdg')
        self.XDG_DATA_DIRS = os.getenv('XDG_DATA_HOME', '/usr/local/share:/usr/share')

        for name in ['CONFIG', 'DATA']:
            self.__setattr__(
                'XDG_' + name + '_DIRS',
                (
                    [self.__getattribute__('XDG_' + name + '_HOME')] +
                    [
                        pathlib.Path(x)
                        for x in self.__getattribute__('XDG_' + name + '_DIRS').split(':')
                    ]
                )
            )


class CustomPrompt:
    """Create a colorized prompt and report actual prompt length."""

    def __init__(self, text: str, color: str, state: Optional[List[str]] = None,
                 suffix: str = ' ') -> None:
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
        suffix :
            Prompt suffix.

        Returns
        -------
        None

        """
        self.color = color
        self.state = state or ['bold']
        self.suffix = suffix
        self.text = text

    def __len__(self) -> int:
        """Return actual length of the prompt.

        All ANSI color escape sequences will be ignored.

        Returns
        -------
        int :
            Adjusted length of prompt.

        """
        return len(self.text) + len(self.suffix)

    def __str__(self) -> str:
        """Add ANSI color escape sequences to a text.

        Returns
        -------
        str :
            Modified text.

        """
        return self.ansi_colorize(self.text, self.color, self.state) + self.suffix

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


def format_time(dt: float, unit: Optional[str] = None, precision: int = 5) -> str:
    """Convert a time delta to a nicely formatted string (with unit).

    Parameters
    ----------
    dt :
        Amount of time in seconds.
    unit :
        Unit of the formatted `dt`.
        May be one of the following: 'sec', 'msec', 'usec' or 'nsec'.
    precision :
        Precision of formating. [1]

    Returns
    -------
    str

    References
    ----------
    .. [1] https://python.org/3/library/string.html#formatspec

    """
    units = {
        'nsec': 1e-9,
        'usec': 1e-6,
        'msec': 1e-3,
        'sec': 1.0,
    }

    if unit is not None:
        scale = units[unit]
    else:
        scales: List[Tuple[float, str]] = [(scale, unit) for unit, scale in units.items()]
        scales.sort(reverse=True)

        for scale, _unit in scales:
            if dt >= scale:
                unit = _unit
                break

    return f'{dt / scale:.{precision}g} {unit}'


def timed(stmt: str = '', setup: str = '', globals_: Optional[Dict[str, Any]] = None,
          repeat: Optional[int] = None, number: Optional[int] = None) -> None:
    """Informative wrapper around `timeit.repeat`.

    Parameters
    ----------
    stmt :
        Statement to be executed.
    setup :
        Statement to be executed once initially.
    globals :
        Namespace in which the code is executed.
    repeat :
        Times the timer is repeated.
    number :
        Times `stmt` is executed.

    Returns
    -------
    None

    """
    import timeit

    number = abs(number or 1_000_000)
    repeat = abs(repeat or 5)

    measurements_raw = timeit.repeat(stmt, setup=setup, globals=globals_,
                                     repeat=repeat, number=number)
    measurements = [dt / number for dt in measurements_raw]

    best = min(measurements)
    worst = max(measurements)

    print(
        f"{number} loop{'s' if number != 1 else ''}, "
        f'best of {repeat}: {format_time(best)} per loop'
    )

    if worst >= best * 4:
        print(
            '\nThe test results are likely unreliable.\n'
            f'The worst time ({format_time(worst)}) was more than four times '
            f'slower than the best time ({format_time(best)}).',
            file=sys.stderr
        )


if __name__ == '__main__':
    cdr = CommonDirectories()

    ################################
    # History
    ################################
    histfile = cdr.XDG_CACHE_HOME / f'python{sys.version_info.major}_history'

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
        contextlib,
        readline,
        rlcompleter,

        # Type hints
        Any,
        Dict,
        List,
        Optional,
        Tuple,

        # Variables
        histfile,

        # Classes
        CommonDirectories,
        CustomPrompt,

        # Functions
        displayhook_pprint,
    )

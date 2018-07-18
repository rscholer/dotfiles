dotfiles
========
This is a collection of my dotfiles.

Although this repository mainly exists for my convenience and as a backup, it
might prove to be of interest to others.

All scripts are used and tested under [Arch Linux][1] and [Arch Linux 32][2].

Please [let me know][3], if and what changes are needed to support other
GNU/Linux distributions and operating systems.

Installation
------------
All configuration packages are installed with [GNU stow][4].

To install all packages run `install.sh`. If you want to install individual
packages run `stow -d src -t ~/ <package>`, although you might need to create
directories and correct file permissions by yourself.

For further information on handling your configuration with GNU stow see it's
[official manual][5].

License
-------
[MIT License][6] unless otherwise noted.


[1]: https://www.archlinux.org/
[2]: https://www.archlinux32.org/
[3]: https://github.com/rscholer/dotfiles/issues
[4]: https://www.gnu.org/software/stow/
[5]: https://www.gnu.org/software/stow/manual/
[6]: LICENSE

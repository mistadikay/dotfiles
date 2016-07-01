#!/usr/bin/env bash
#
# Initial installation

# set hostname
scutil --set HostName mistadikay

# install fishmarks
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish

# set symlinks from .dotfiles
./sync.sh

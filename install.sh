#!/usr/bin/env bash
#
# Initial installation

dotfiles="$HOME/.dotfiles"

# set hostname
scutil --set HostName mistadikay

# install fishmarks
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish

# Git
$dotfiles/git/install.sh

# set symlinks from .dotfiles
./sync.sh

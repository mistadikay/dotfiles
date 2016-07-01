#!/usr/bin/env bash
#
# Initial installation

dotfiles="$HOME/.dotfiles"

# set hostname
scutil --set HostName mistadikay

# install fishmarks
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish

# Bash
bash $dotfiles/bash/install.sh

# Git
bash $dotfiles/git/install.sh

# Vim
bash $dotfiles/vim/install.sh

# set symlinks from .dotfiles
bash $dotfiles/sync.sh

echo "\(• ◡ •)/      dotfiles installed!     ᕕ( ᐛ )ᕗ"
printf "\n"

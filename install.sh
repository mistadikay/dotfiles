#!/usr/bin/env bash
#
# Initial installation
#
# This is something we need to do just once for a new system

dotfiles="$HOME/.dotfiles"

# set hostname
scutil --set HostName mistadikay

# Bash
bash $dotfiles/bash/install.sh

# Git
bash $dotfiles/git/install.sh

# Fish
bash $dotfiles/fish/install.sh

# Vim
bash $dotfiles/vim/install.sh

# Atom
bash $dotfiles/atom/install.sh

# set symlinks from .dotfiles
bash $dotfiles/sync.sh

echo "\(• ◡ •)/      dotfiles installed!     ᕕ( ᐛ )ᕗ"
printf "\n"

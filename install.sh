#!/usr/bin/env bash
#
# Initial installation
#
# This is something we need to do just once for a new system

dotfiles="$HOME/.dotfiles"

# Install, setup and symlink everything
bash $dotfiles/macos/install.sh
bash $dotfiles/bash/install.sh
bash $dotfiles/git/install.sh
bash $dotfiles/fish/install.sh
bash $dotfiles/homebrew/install.sh
bash $dotfiles/npm/install.sh
bash $dotfiles/vim/install.sh
bash $dotfiles/atom/install.sh
bash $dotfiles/hyperterm/install.sh

# Synchronize
bash $dotfiles/sync.sh

echo "\(• ◡ •)/      dotfiles installed!     ᕕ( ᐛ )ᕗ"
printf "\n"

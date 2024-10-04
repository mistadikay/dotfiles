#!/usr/bin/env bash
#
# Initial installation
#
# This is something we need to do just once for a new system

dotfiles="$HOME/.dotfiles"

# Install, setup and symlink everything
bash $dotfiles/homebrew/install.sh
bash $dotfiles/fish/install.sh
bash $dotfiles/macos/install.sh
bash $dotfiles/bash/install.sh
bash $dotfiles/git/install.sh
bash $dotfiles/npm/install.sh
bash $dotfiles/asdf/install.sh
bash $dotfiles/psql/install.sh
bash $dotfiles/tmux/install.sh
bash $dotfiles/wezterm/install.sh

echo "\(• ◡ •)/      dotfiles installed!     ᕕ( ᐛ )ᕗ"
printf "\n"

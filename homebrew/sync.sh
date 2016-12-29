#!/usr/bin/env bash
#
# Homebrew Synchronization

src="$HOME/.dotfiles/homebrew"

echo "Syncing Homebrew"

cd "$src"
brew bundle dump --force

printf "\n"

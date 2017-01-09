#!/usr/bin/env bash
#
# Homebrew Installation

src="$HOME/.dotfiles/homebrew"
brew="$(brew --prefix)/bin/brew"

echo "Installing Homebrew stuff"
echo "│"
echo "└── Restoring from bundle..."
cd "$src"
$brew bundle --force

printf "\n"

#!/usr/bin/env bash
#
# Homebrew Installation

dotfiles="$HOME/.dotfiles"
brew="$(brew --prefix)/bin/brew"

echo "Installing Homebrew stuff"
echo "│"
echo "└── Restoring from bundle..."
$brew bundle

printf "\n"

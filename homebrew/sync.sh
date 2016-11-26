#!/usr/bin/env bash
#
# Homebrew Synchronization

brew="$(brew --prefix)/bin/brew"

echo "Syncing Homebrew"
$brew bundle dump --force

printf "\n"

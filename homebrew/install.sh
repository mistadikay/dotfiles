#!/usr/bin/env bash
#
# Homebrew Installation

dotfiles="$HOME/.dotfiles"
brew="$(brew --prefix)/bin/brew"

echo "Installing Homebrew stuff"
echo "│"
echo "└── Enabling taps..."
for TAP in `cat $dotfiles/homebrew/brew-sync.taps`; do
	$brew tap ${TAP} >/dev/null
done

echo "│"
echo "└── Installing missing packages..."
for PACKAGE in `cat $dotfiles/homebrew/brew-sync.installed`; do
	$brew leaves ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $brew install ${PACKAGE}
done

echo "│"
echo "└── Installing missing casks..."
for CASK in `cat $dotfiles/homebrew/brew-sync.casks`; do
	$brew cask list -1 ${CASK} >/dev/null
	[ "$?" != "0" ] && $brew cask install ${CASK}
done

printf "\n"

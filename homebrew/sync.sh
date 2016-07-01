#!/usr/bin/env bash
#
# Homebrew Synchronization
# based on  https://gist.github.com/witt3rd/894c9e0b9ca4e24e5574
#
# 1. taps
# 2. casks
# 3. packages

dotfiles="$HOME/.dotfiles"
brew="$(brew --prefix)/bin/brew"

echo "Syncing Homebrew"
echo "└── Reading local settings..."
rm -f /tmp/brew-sync.*
$brew tap > /tmp/brew-sync.taps
$brew leaves > /tmp/brew-sync.installed
$brew cask list -1 > /tmp/brew-sync.casks

echo "│"
echo "└── Reading settings from dotfiles repo..."
[ -e $dotfiles/homebrew/brew-sync.taps ] && cat $dotfiles/homebrew/brew-sync.taps >> /tmp/brew-sync.taps
[ -e $dotfiles/homebrew/brew-sync.installed ] && cat $dotfiles/homebrew/brew-sync.installed >> /tmp/brew-sync.installed
[ -e $dotfiles/homebrew/brew-sync.casks ] && cat $dotfiles/homebrew/brew-sync.casks >> /tmp/brew-sync.casks

echo "│"
echo "└── Syncing to dotfiles repo..."
mkdir -p $dotfiles/homebrew
cat /tmp/brew-sync.taps | sort | uniq > $dotfiles/homebrew/brew-sync.taps
cat /tmp/brew-sync.installed | sort | uniq > $dotfiles/homebrew/brew-sync.installed
cat /tmp/brew-sync.casks | sort | uniq > $dotfiles/homebrew/brew-sync.casks

echo "│"
echo "└── Enabling taps..."
for TAP in `cat $dotfiles/homebrew/brew-sync.taps`; do
	$brew tap ${TAP} >/dev/null
done

echo "│"
echo "└── Install missing packages..."
for PACKAGE in `cat $dotfiles/homebrew/brew-sync.installed`; do
	$brew leaves ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $brew install ${PACKAGE}
done

echo "│"
echo "└── Install missing casks..."
for CASK in `cat $dotfiles/homebrew/brew-sync.casks`; do
	$brew cask list -1 ${CASK} >/dev/null
	[ "$?" != "0" ] && $brew cask install ${CASK}
done

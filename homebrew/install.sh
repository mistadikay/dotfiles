#!/usr/bin/env bash

echo "└── Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# add brew to PATH
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/denis.koltsov/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew upgrade
brew tap homebrew/cask-drivers

echo "└── Installing brew packages"
brew install asdf
brew install awscli
brew install git
brew install gnupg
brew install go
brew install fish
brew install kubernetes-cli
brew install m-cli
brew install mas
brew install openjdk
brew install starship
brew install rustup-init
brew install vault
brew install yarn
brew install youtube-dl

echo "└── Installing brew casks"
brew install --cask 1password
brew install --cask bartender
brew install --cask bettertouchtool
brew install --cask docker
brew install --cask dropbox
brew install --cask firefox
brew install --cask focus
brew install --cask istat-menus
brew install --cask iterm2
brew install --cask jetbrains-toolbox
brew install --cask obsidian
brew install --cask postman
brew install --cask steam
brew install --cask sublime-text

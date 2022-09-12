#!/usr/bin/env bash

echo "└── Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew upgrade
brew tap homebrew/cask-drivers
brew tap janniks/git-ignore

echo "└── Installing brew packages"
brew install act
brew install awscli
brew install gh
brew install git
brew install git-ignore
brew install gnupg
brew install go
brew install fish
brew install hugo
brew install jq
brew install kubernetes-cli
brew install logitech-options
brew install m-cli
brew install mas
brew install nvm
brew install openjdk
brew install rustup-init
brew install vault
brew install yarn
brew install youtube-dl

echo "└── Installing brew casks"
brew install --cask 1password
brew install --cask bartender
brew install --cask bettertouchtool
brew install --cask brave-browser
brew install --cask docker
brew install --cask dropbox
brew install --cask firefox
brew install --cask figma
brew install --cask focus
brew install --cask istat-menus
brew install --cask iterm2
brew install --cask jetbrains-toolbox
brew install --cask keybase
brew install --cask lastpass
brew install --cask notion
brew install --cask postman
brew install --cask protonmail-bridge
brew install --cask qlmarkdown
brew install --cask qlstephen
brew install --cask qlvideo
brew install --cask quicklook-json
brew install --cask skype
brew install --cask sourcetree
brew install --cask steam
brew install --cask sublime-text
brew install --cask transmission
brew install --cask vlc
brew install --cask yacreader
brew install --cask zettlr

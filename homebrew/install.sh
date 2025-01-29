#!/usr/bin/env bash

echo "└── Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add brew to PATH
echo >> /Users/deniskoltsov/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/deniskoltsov/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew upgrade

echo "└── Installing brew packages"
brew install asdf
brew install awscli
brew install bat
brew install eza
brew install fish
brew install git
brew install gnupg
brew install helm
brew install kubernetes-cli
brew install m-cli
brew install mas
brew install ollama
brew install opentofu
brew install pinentry-mac
brew install starship
brew install stats
brew install tflint
brew install tmux

echo "└── Installing brew casks"
brew install --cask 1password
brew install --cask anki
brew install --cask appcleaner
brew install --cask bartender
brew install --cask brave-browser
brew install --cask bruno
brew install --cask chatgpt
brew install --cask docker
brew install --cask figma
brew install --cask firefox
brew install --cask focus
brew install --cask garmin-express
brew install --cask jetbrains-toolbox
brew install --cask obsidian
brew install --cask protonmail-bridge
brew install --cask slack
brew install --cask steam
brew install --cask telegram
brew install --cask thunderbird
brew install --cask vscodium
brew install --cask wezterm

echo "└── Starting brew services"
brew services start ollama
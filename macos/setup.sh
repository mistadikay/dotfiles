#!/usr/bin/env bash

# Dock
echo "Move dock to the left"
defaults write com.apple.dock orientation left

echo "Turn Hiding on"
defaults write com.apple.dock autohide -bool true

echo "Remove hiding animation delay"
defaults write com.apple.dock autohide-delay -float 0

echo "Turn Magnification on"
defaults write com.apple.dock magnification -bool true

echo "Hide recent apps"
defaults write com.apple.dock show-recents -bool false

echo "Set dock icon size (min-max)"
defaults write com.apple.dock tilesize -float 48
defaults write com.apple.dock largesize -float 56

echo "Remove all apps from the dock"
defaults write com.apple.dock persistent-apps -array

echo "Reload the dock"
killall Dock

# Finder
echo "Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "Show all filename extensions in Finder"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keyboard
echo "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Set a blazingly fast keyboard repeat rate"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Safari
echo "Enable Safari’s debug menu"
defaults write com.apple.safari IncludeInternalDebugMenu -bool true

echo "Show favorites bar in Safari by default"
defaults write com.apple.safari ShowFavoritesBar -bool true

echo "TODO: Safari opens with last session"

echo "TODO: Keyboard -> App Shortcuts -> Safari -> 'Close Tab' shortcut"

# Desktop & Screen Saver
echo "TODO: Active Screen Corners -> Top Right -> Launchpad"

# Menu bar
echo "TODO: Show bluetooth icon"

echo "TODO: Hide the day of the week"

echo "TODO: Hide the date"

echo "TODO: Show analog clock"

echo "TODO: Hide spotlight"

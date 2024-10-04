#!/usr/bin/env bash

echo "└── Tweaking macOS settings"
scutil --set HostName deniskoltsov
./setup.sh

# for Steam and other non-arm apps
echo "└── Installing Rosetta"
softwareupdate --install-rosetta --agree-to-license

echo "└── Installing apps from Mac App Store"
mas lucky daisydisk

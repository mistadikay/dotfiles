#!/usr/bin/env bash

echo "└── Tweaking macOS settings"
scutil --set HostName mistadikay

echo "└── Installing apps from Mac App Store"
mas lucky cleanmymacx
mas lucky copyclip
mas lucky daisydisk
mas lucky gemini
mas lucky kindle
mas lucky mactracker
mas lucky nordvpn
mas lucky omnifocus3
mas lucky owly
mas lucky slack
mas lucky telegram
mas lucky tweetbot3
mas lucky wallcat
mas install 497799835 #xcode

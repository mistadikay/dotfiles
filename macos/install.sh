#!/usr/bin/env bash

echo "└── Tweaking macOS settings"
scutil --set HostName deniskoltsov

echo "└── Installing apps from Mac App Store"
mas lucky copyclip
mas lucky daisydisk
mas lucky gemini

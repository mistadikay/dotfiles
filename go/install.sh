#!/usr/bin/env bash
#
# Prepare `go` directory

echo "Preparing Go stuff"

echo "└── Creating GOPATH"

mkdir ~/go
mkdir ~/go/bin
mkdir ~/go/go_appengine

# https://github.com/moovweb/gvm
echo "└── Installing GVM"

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)


printf "\n"

#!/usr/bin/env bash
#
# macOS stuff

echo "Setup macOS stuff"

# install m-cli
cd ~
curl -fsSL https://raw.githubusercontent.com/rgcr/m-cli/master/install.sh | sh

# set hostname
scutil --set HostName mistadikay

printf "\n"

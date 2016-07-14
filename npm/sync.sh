#!/usr/bin/env bash
#
# NPM global packages synchronization

src="$HOME/.dotfiles/npm"

echo "Syncing NPM"
echo "└── Reading local settings"
rm -f /tmp/npm-sync.installed
for PACKAGE in `npm ls -g --depth=0`; do
	if [[ $PACKAGE == *"@"* ]]; then
		echo $(echo $PACKAGE | cut -d '@' -f 1) >> /tmp/npm-sync.installed
	fi
done

echo "│"
echo "└── Reading settings from dotfiles repo"
[ -e $src/npm-sync.installed ] && cat $src/npm-sync.installed >> /tmp/npm-sync.installed

echo "│"
echo "└── Syncing to dotfiles repo"
mkdir -p $src
cat /tmp/npm-sync.installed | sort | uniq > $src/npm-sync.installed

echo "│"
echo "└── Install missing packages..."
npm install -g $(cat $src/npm-sync.installed | tr \\n ' ')

printf "\n"

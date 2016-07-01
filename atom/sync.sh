#!/usr/bin/env bash
#
# Atom packages synchronization

src="$HOME/.dotfiles/atom"

echo "Syncing Atom"
echo "└── Reading local settings"
rm -f /tmp/atom-sync.installed
for PACKAGE in `apm list --installed --bare`; do
	echo $(echo $PACKAGE | cut -d '@' -f 1) >> /tmp/atom-sync.installed
done

echo "│"
echo "└── Reading settings from dotfiles repo"
[ -e $src/atom-sync.installed ] && cat $src/atom-sync.installed >> /tmp/atom-sync.installed

echo "│"
echo "└── Syncing to dotfiles repo"
mkdir -p $src
cat /tmp/atom-sync.installed | sort | uniq > $src/atom-sync.installed

echo "│"
echo "└── Install missing packages..."
apm install --packages-file $src/atom-sync.installed

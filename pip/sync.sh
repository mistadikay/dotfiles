#!/usr/bin/env bash
#
# pip3 packages synchronization

src="$HOME/.dotfiles/pip"

echo "Syncing pip"
echo "└── Reading local settings"
rm -f /tmp/pip-sync.installed
for PACKAGE in `pip3 freeze`; do
	if [[ $PACKAGE == *"="* ]]; then
		echo $(echo $PACKAGE | cut -d '=' -f 1) >> /tmp/pip-sync.installed
	fi
done

echo "│"
echo "└── Reading settings from dotfiles repo"
[ -e $src/pip-sync.installed ] && cat $src/pip-sync.installed >> /tmp/pip-sync.installed

echo "│"
echo "└── Syncing to dotfiles repo"
mkdir -p $src
cat /tmp/pip-sync.installed | sort | uniq > $src/pip-sync.installed

echo "│"
echo "└── Install missing packages..."
pip3 install $(cat $src/pip-sync.installed | tr \\n ' ') --upgrade

printf "\n"

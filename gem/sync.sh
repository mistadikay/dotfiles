#!/usr/bin/env bash
#
# gem packages synchronization

src="$HOME/.dotfiles/gem"

echo "Syncing gem"
echo "└── Reading local settings"
rm -f /tmp/gem-sync.installed
for PACKAGE in `gem list --local`; do
	if [[ $PACKAGE != "("* && $PACKAGE != *")" ]]; then
		echo $PACKAGE >> /tmp/gem-sync.installed
	fi
done

echo "│"
echo "└── Reading settings from dotfiles repo"
[ -e $src/gem-sync.installed ] && cat $src/gem-sync.installed >> /tmp/gem-sync.installed

echo "│"
echo "└── Syncing to dotfiles repo"
mkdir -p $src
cat /tmp/gem-sync.installed | sort | uniq > $src/gem-sync.installed

echo "│"
echo "└── Install missing packages..."
gem install $(cat $src/gem-sync.installed | tr \\n ' ')

printf "\n"

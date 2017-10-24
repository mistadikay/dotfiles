# update dependencies
function up
	switch (uname)
	case Linux
		sudo apt update
		sudo apt full-upgrade
	case '*'
		# show mac updates
		softwareupdate -l

		# upgrade mac apps
		mas upgrade

		# brew
		brew update --rebase
		brew upgrade
		brew cleanup -s --force
		brew cask cleanup
		brew prune

		# https://github.com/rgcr/m-cli
		m --update
	end

	# https://github.com/fish-shell/fish-shell/blob/master/doc_src/fish_update_completions.txt
	fish_update_completions

	# update fishmarks (https://github.com/techwizrd/fishmarks)
	cd ~/.fishmarks
	git fetch --all
	git reset --hard origin/master

	# update fisher
	fisher update

	# update npm and global npm packages
	npm i npm -g
	npm update -g
end

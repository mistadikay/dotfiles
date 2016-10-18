# update dependencies
function up
	# show mac updates
	softwareupdate -l

	# brew
	brew update --rebase
	brew upgrade
	brew cleanup -s --force
	brew cu
	brew cask cleanup
	brew prune

	# https://github.com/fish-shell/fish-shell/blob/master/doc_src/fish_update_completions.txt
	fish_update_completions

	# https://github.com/rgcr/m-cli
	m --update

	# update fishmarks (https://github.com/techwizrd/fishmarks)
	cd ~/.fishmarks
	git fetch --all
	git reset --hard origin/master

	# update fisher
	fisher update

	# update npm and global npm packages
	npm i npm -g
	npm update -g

	# update atom packages
	apm upgrade --confirm false
end

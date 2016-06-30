# update dependencies
function up
	# show mac updates
	softwareupdate -l

	# brew
	brew update --rebase
	brew upgrade --all
	sudo brew cleanup -s --force
	sudo brew cask cleanup
	sudo brew prune

	# https://github.com/fish-shell/fish-shell/blob/master/doc_src/fish_update_completions.txt
	fish_update_completions

	# update fishmarks (https://github.com/techwizrd/fishmarks)
	cd ~/.fishmarks
	git fetch --all
	git reset --hard origin/master

	# update npm and global npm packages
	npm i npm -g
	npm update -g

	# update atom packages
	apm upgrade --confirm false
end

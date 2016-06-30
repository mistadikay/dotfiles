# set access to the current user
#
# TODO not sure if need this one:
# sudo chown -R {$USER} (brew --prefix)
# sudo chown -R {$USER} /usr/local
function cho
	sudo chown -R {$USER} $argv[1]
end

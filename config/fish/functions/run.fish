# shortcut for npm start
function run
	if test $argv[1]
		npm start $argv[1]
	else
		npm start
	end
end

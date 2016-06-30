# finds process on port
function findp
	lsof -n -i4TCP:$argv[1]
end

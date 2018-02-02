# https://github.com/moovweb/gvm
function gvm
  bass source ~/.gvm/scripts/gvm ';' gvm $argv
  # otherwise gvm overwrites GOPATH
  set --export GOPATH $HOME/go
end

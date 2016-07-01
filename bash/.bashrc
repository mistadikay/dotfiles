##    __            __
#    / /  ___ ____ / /  ________
#   / _ \/ _ `(_-</ _ \/ __/ __/
#  /_.__/\_,_/___/_//_/_/  \__/
#
##
# check if os is mac
#/
darwin() {
  [ "$(uname)" = "Darwin" ]
}
##
# who's your daddy?
#/
owner() {
  if [ -n "$1" ]; then
    if darwin; then
      stat -f "%Su" "$1"
    else
      stat -c "%U" "$1"
    fi
  fi
}
##
# easy append to $PATH
#/
append() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

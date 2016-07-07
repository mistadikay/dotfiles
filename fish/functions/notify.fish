# notify about finishing last command if iTerm is not in focus
# example:
#   npm info react; and notify
#
# or just add to fish_prompt
#
function notify
    osascript ~/.dotfiles/applescript/notifyme.applescript $history[1] $status
end

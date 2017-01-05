# Unsets “Do Not Disturb” status
# before using replace TOKEN with a token value from https://api.slack.com/docs/oauth-test-tokens
curl -L "https://slack.com/api/dnd.endSnooze?token=TOKEN"

# reopen distracting apps
open -a Franz
open -a Spark
open -a Tweetbot

# trigger dnd-mode in macOS
osascript ~/.dotfiles/applescript/dnd.applescript

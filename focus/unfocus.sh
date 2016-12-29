# get TOKEN(s) from https://api.slack.com/docs/oauth-test-tokens
# unset Do Not Disturb status
curl -L "https://slack.com/api/dnd.endSnooze?token=TOKEN"

# reopen distructing apps
osascript -e 'open app "Slack"'
osascript -e 'open app "Spark"'
osascript -e 'open app "Tweetbot"'

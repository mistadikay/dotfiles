# get TOKEN(s) from https://api.slack.com/docs/oauth-test-tokens
# set Do Not Disturb status for 60 minutes
curl -L "https://slack.com/api/dnd.setSnooze?token=TOKEN&num_minutes=60"

# close distructing apps
osascript -e 'quit app "Slack"'
osascript -e 'quit app "Spark"'
osascript -e 'quit app "Tweetbot"'

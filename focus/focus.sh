# Sets “Do Not Disturb” status for (FOCUS_INTERVAL / 60) minutes
# FOCUS_INTERVAL is amount of seconds user focuses on (env variable from Focus.app), default: 1500
# before using replace TOKEN with a token value from https://api.slack.com/docs/oauth-test-tokens
curl -L "https://slack.com/api/dnd.setSnooze?token=TOKEN&num_minutes=$(expr $FOCUS_INTERVAL '/' 60)"

# close distracting apps
osascript -e 'quit app "Franz"'
osascript -e 'quit app "Spark"'
osascript -e 'quit app "Tweetbot"'

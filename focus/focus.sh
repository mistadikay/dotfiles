# Sets “Do Not Disturb” status for (FOCUS_INTERVAL / 60) minutes
# FOCUS_INTERVAL is amount of seconds user focuses on (env variable from Focus.app)
# note: $FOCUS_INTERVAL is 0 by default, otherwise it's the interval for the previous focus session
if [ "$FOCUS_INTERVAL" -eq "0" ]; then
    FOCUS_INTERVAL=1500
fi
FOCUS_MINUTES=$((FOCUS_INTERVAL / 60))

# before using replace TOKEN with a token value from https://api.slack.com/tutorials/tracks/getting-a-token
# repeat the command below for each workspace you need to change DND-status for
TOKEN=User OAuth Token
curl -H "Authorization: Bearer $TOKEN" "https://slack.com/api/dnd.setSnooze?num_minutes=$FOCUS_MINUTES"

# close distracting apps
osascript -e 'quit app "Mail"'
osascript -e 'quit app "Tweetbot"'

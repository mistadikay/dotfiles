# Unsets “Do Not Disturb” status
# before using replace TOKEN with a token value from https://api.slack.com/tutorials/tracks/getting-a-token
# repeat the command below for each workspace you need to change DND-status for
TOKEN=User OAuth Token
curl -H "Authorization: Bearer $TOKEN" "https://slack.com/api/dnd.endSnooze"

# reopen distracting apps
open -a "Mail"
open -a "Telegram"
open -a "Tweetbot"

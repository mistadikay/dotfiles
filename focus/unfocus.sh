# get TOKEN(s) from https://api.slack.com/docs/oauth-test-tokens
# unset Do Not Disturb status
curl -L "https://slack.com/api/dnd.endSnooze?token=TOKEN"

# reopen distracting apps
open -a Franz
open -a Spark
open -a Tweetbot

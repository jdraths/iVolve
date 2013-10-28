#This initializes the Twitter client throughout the app with iVolve consumer Key and Secret.
# Need to move iVolve's consumer key and secret to environment variables so that they are hidden.
Twitter.configure do |config|
  config.consumer_key        = "iA0zWYfLeg2aWA35cxi5g"
  config.consumer_secret     = "S0GVADK1a4HGjp9QgVKydKn7YgetC0uHLtqScNa0"
  #user's below
  #config.oauth_token = ""
  #config.oauth_token_secret = ""
end

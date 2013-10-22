#This initializes the Twitter client throughout the app with iVolve consumer Key and Secret.
# Need to move iVolve's consumer key and secret to environment variables so that they are hidden.
Twitter.configure do |config|
  config.consumer_key        = "iA0zWYfLeg2aWA35cxi5g"
  config.consumer_secret     = "S0GVADK1a4HGjp9QgVKydKn7YgetC0uHLtqScNa0"
  # below is reilly's
  #config.oauth_token        = "145625913-el3YXDa5P0cQBbSvrFIM2puXmc9Y7QyLrN7qMb79"
  #config.oauth_token_secret = "IGauXnwEXkJoHecfVbBuRNmzeEA1yOQAzWHUe4Jtk"

end

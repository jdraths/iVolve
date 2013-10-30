#This initializes the Twitter client throughout the app with iVolve consumer Key and Secret.
# Need to move iVolve's consumer key and secret to environment variables so that they are hidden.
Twitter.configure do |config|
  config.consumer_key        = "iA0zWYfLeg2aWA35cxi5g"
  config.consumer_secret     = "S0GVADK1a4HGjp9QgVKydKn7YgetC0uHLtqScNa0"
  #roanedraths's below
  #config.oauth_token = "554545209-0RwRopFqWC12uH6raEPVV3ZfEtgsG0oloblixtQ0"
  #config.oauth_token_secret = "sTzqbhd5gOG6Pibc6cSFRDXzdNxvuR9qaAO3kPf8tLk"
end

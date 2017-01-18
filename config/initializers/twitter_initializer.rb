twiiter_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWIITER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWIITER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWIITER_ACCESS_SECRET"]
end

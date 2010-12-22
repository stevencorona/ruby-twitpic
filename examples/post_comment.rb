require '../lib/twitpic'

twitpic = TwitPic::Client.new

twitpic.configure do |conf|
  conf.api_key = "your API key"
  conf.consumer_key = "your consumer key"
  conf.consumer_secret = "your consumer secret"
  conf.oauth_token = "users oauth token"
  conf.oauth_secret = "users oauth secret"
end

comment = twitpic.comments(:create, {:media_id => "3g77xc", :message => "Testing from Ruby!"})

puts comment.to_s
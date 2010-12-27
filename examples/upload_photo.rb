require '../lib/twitpic'

twitpic = TwitPic::Client.new

# This part is optional and only required if you are calling
# write enabled methods against the TwitPic API, which we are here.
twitpic.configure do |conf|
  conf.api_key = "your api key"
  conf.consumer_key = "app consumer key"
  conf.consumer_secret = "app consumer secret"
  conf.oauth_token = "user oauth token"
  conf.oauth_secret = "user oauth secret"
end

media = twitpic.upload("/path/to/file.jpg", "Uploading from Ruby!")

puts media.to_s
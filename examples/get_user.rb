require '../lib/twitpic'

username = 'meltingice'

if ARGV.length > 0 then
  username = ARGV[0]
end

twitpic = TwitPic::Client.new

# This part is optional and only required if you are calling
# write enabled methods against the TwitPic API.
twitpic.configure do |conf|
  conf.api_key = "your API key"
  conf.consumer_key = "your consumer key"
  conf.consumer_secret = "your consumer secret"
  conf.oauth_token = "users oauth token"
  conf.oauth_secret = "users oauth secret"
end

user = twitpic.users(:show, {:username => username})

puts "Username: #{user['username']}, ID ##{user['id']}"
puts "Last photo: http://twitpic.com/" + user['images'][0]['short_id']
require '../lib/twitpic'

username = 'meltingice'

if ARGV.length > 0 then
  username = ARGV[0]
end

twitpic = TwitPic::Client.new

user = twitpic.users(:show, {:username => username})

puts "Username: #{user['username']}, ID ##{user['id']}"
puts "Last photo: http://twitpic.com/" + user['images'][0]['short_id']
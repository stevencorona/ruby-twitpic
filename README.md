<h1>TwitPic API for Ruby</h1>
The TwitPic library provides full access to the TwitPic API, including photo uploads (uploadAndPost not implemented yet) and write-enabled API methods.

<h1>Dependencies</h1>
All of these are required, but are available as gems:

* Nestful (used to be Net::HTTP, switched to Nestful to make the code cleaner and shorter)
* ROAuth
* JSON

<h1>Example Usage</h1>
Check out the examples in the examples folder to find out how to use the library.  The gist of it is:

<pre>
require './lib/twitpic'

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

user = twitpic.users(:show, {:username => "some_username"})
puts "User ID: #{user['id']}"
puts "Last Photo: http://twitpic.com/#{user['images'][0]['short_id']}"

media = twitpic.upload("path/to/file.jpg", "My photo caption")
</pre>

<h1>Project To-Do</h1>
* Unit testing
* More examples perhaps?
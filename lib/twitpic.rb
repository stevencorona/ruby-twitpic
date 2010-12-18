module TwitPic; end

# Helper for Rails < 1.9.x
def require_local(path)
  require(File.expand_path(File.join(File.dirname(__FILE__), path)))
end

# Load the required libraries
require 'net/http'
require 'roauth'
require 'uri'
require 'json'

# Load the TwitPic API library
require_local 'twitpic/ext/util'
require_local 'twitpic/config'
require_local 'twitpic/api'
require_local 'twitpic/client'
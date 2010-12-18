module TwitPic
  class Config
    attr_accessor :api_key, :consumer_key, :consumer_secret, :oauth_token, :oauth_secret
    
    # Setup the default configuration data
    def initialize
      @api_key = ''
      @consumer_key = ''
      @consumer_secret = ''
      @oauth_token = ''
      @oauth_secret = ''
    end
  end
end
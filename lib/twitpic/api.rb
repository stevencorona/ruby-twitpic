Dir.glob(File.dirname(__FILE__) + '/api/*') {|file| require file}

module TwitPic
  module API
    API_BASE = 'http://api.twitpic.com/2/'
    
    class << self

      public
      
      def query(client, call, args)
        self.validate(call, args)
        
        if call[:method] == :get then
          TwitPic::API.get(call[:endpoint], args)
        else
          TwitPic::API.post(client, call[:endpoint], args)
        end
      end
    
      protected
      
      def get(endpoint, args = {})
        query_string = args.to_http_str
        url = URI.parse(API_BASE + endpoint + ".json?" + query_string)
        
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.get(url.to_s)
        }
        
        # If we don't get a 200 response, raise an error
        res.error! unless Net::HTTPSuccess
        
        # Finally, parse the JSON data and return it
        data = JSON.parse(res.body)
      end
      
      def post(client, endpoint, args = {})
        # disable write-enabled calls for now. having issues with authentication... the signature
        # must be off for some reason.
        raise NotImplementedError, "Write-enabled API calls are not finished being implemented yet"
        
        query_string = args.to_http_str
        headers = TwitPic::API.build_header(client)
        
        url = URI.parse(API_BASE + endpoint + ".json?")
        http = Net::HTTP.new(url.host)
        resp, data = http.post(url.path, query_string, headers)
        
        puts resp.to_s
        puts data
      end
      
      def build_header(client)
        raise RuntimeError, "Missing application or OAuth credentials" unless client.write_enabled
        
        oauth_url = "https://api.twitter.com/1/account/verify_credentials.json"
        
        info = {
          :access_key => client.config.oauth_token,
          :access_secret => client.config.oauth_secret,
          :consumer_key => client.config.consumer_key,
          :consumer_secret => client.config.consumer_secret
        }
        
        result = ::ROAuth.header(info, oauth_url, {})
        
        headers = {
          'X-Auth-Service-Provider' => oauth_url,
          'X-Verify-Credentials-Authorization' => result
        }
      end
      
      def validate(info, args)
        info[:required].each do |item|
          raise ArgumentError, "Missing required argument " + item + " for " + info[:endpoint] unless args.keys.member?(item)
        end
      end
    end
  end
end
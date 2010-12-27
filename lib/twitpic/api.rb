Dir.glob(File.dirname(__FILE__) + '/api/*') {|file| require file}

module TwitPic
  module API
    API_BASE = 'http://api.twitpic.com/2/'
    
    class << self

      public
      
      def query(client, call, args)
        self.validate(call, args)
        
        if call[:method] == :get then
          self.get(call[:endpoint], args)
        else
          self.post(client, call[:endpoint], args)
        end
      end
      
      # Uploads an image to the TwitPic API
      #
      # File can be either the path to the image or
      # a File object
      def upload(client, file, args)
      	file = File.open(file) if file.instance_of? String
				
				args[:media] = file
				
				self.post(client, 'upload', args)
      end
    
      protected
      
      def get(endpoint, args = {})
        url = API_BASE + endpoint + ".json"
        data = Nestful.json_get(url, args)
      end
      
      def post(client, endpoint, args = {})  
      	url = API_BASE + endpoint + ".json"
      	      
        # Add API key to arguments
        args['key'] = client.config.api_key

        headers = TwitPic::API.build_header(client)
        opts = {
        	:headers => headers,
        	:params => args
        }
        
        if endpoint == 'upload' then
        	opts[:format] = :multipart
        end
        
        data = Nestful.post(url, opts)
				JSON.parse(data)
      end
      
      def build_header(client)
        raise RuntimeError, "Missing application or OAuth credentials" unless client.write_enabled
        
        oauth_url = "https://api.twitter.com/1/account/verify_credentials.json"
        
        info = {
          :access_key => client.config.oauth_token,
          :access_secret => client.config.oauth_secret,
          :consumer_key => client.config.consumer_key,
          :consumer_secret => client.config.consumer_secret,
          :signature_method => "HMAC-SHA1"
        }
        
        result = ::ROAuth.header(info, oauth_url, {}, :get)

        headers = {
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
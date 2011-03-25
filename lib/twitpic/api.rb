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
      
      def tweet(client, media)
        raise ArgumentError, "Invalid argument, must be an object returned from a photo upload" unless media.has_key? 'text'
        
        tweet = "#{media['text'][0..114]} #{media['url']}"
        url = 'http://api.twitter.com/1/statuses/update.json';
        headers = TwitPic::API.build_header(client, tweet)

        opts = {
          :headers => headers,
          :params => {
            'status' => tweet
          }
        }
        
        data = Nestful.post(url, opts)
        
        return media, JSON.parse(data)
      end
    
      protected
      
      def get(endpoint, args = {})
        url = API_BASE + endpoint + ".json"
        data = Nestful.get(url, :params => args)
        JSON.parse(data)
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
      
      def build_header(client, tweet=nil)
        raise RuntimeError, "Missing application or OAuth credentials" unless client.write_enabled
        
        info = {
          :access_key => client.config.oauth_token,
          :access_secret => client.config.oauth_secret,
          :consumer_key => client.config.consumer_key,
          :consumer_secret => client.config.consumer_secret,
          :signature_method => "HMAC-SHA1"
        }
        
        if tweet then
          oauth_url = "http://api.twitter.com/1/statuses/update.json"
          result = ::ROAuth.header(info, oauth_url, {'status' => tweet}, :post)
          
          headers = {
            'Authorization' => result
          }
        else
          oauth_url = "https://api.twitter.com/1/account/verify_credentials.json"
          result = ::ROAuth.header(info, oauth_url, {}, :get)
          
          headers = {
            'X-Verify-Credentials-Authorization' => result
          }
        end
      end
      
      def validate(info, args)
        info[:required].each do |item|
          raise ArgumentError, "Missing required argument " + item + " for " + info[:endpoint] unless args.keys.member?(item)
        end
      end
    end
  end
end
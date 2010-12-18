module TwitPic
  # The base interaction class. All of the API methods are called via
  # the client class once a Client object is created.
  class Client
  
    attr_reader :config, :write_enabled
    
    def initialize
      @config = TwitPic::Config.new
    end
    
    # Lets you change configuration options
    def configure(&block)
      raise ArgumentError, "Block required in order to configure" unless block_given?
      
      yield @config
    end
    
    # Determines whether all of the required information has been entered into the config
    # so we know if we can make a write-enabled call or not.  Is this too ghetto/unsafe?
    def write_enabled
      enabled = true
      TwitPic::Config.instance_methods.grep(/\w=$/).each do |method|
        enabled = false unless @config.send(method.to_s.chop).strip.length > 0
      end
    end
  end
end
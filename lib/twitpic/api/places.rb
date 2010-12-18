class TwitPic::Client
  @@PLACE_API = {
    :show => {
      :endpoint => 'place/show',
      :method => :get,
      :required => [:id]
    }
  }
  
  @@PLACES_API = {
    :show => {
      :endpoint => 'places/show',
      :method => :get,
      :required => [:user]
    }
  }
  
  def place(action, args)
    raise ArgumentError, "Invalid API action given" unless @@PLACE_API.keys.member?(action)
    TwitPic::API.query(self, @@PLACE_API[action], args)
  end
  
  def places(action, args)
    raise ArgumentError, "Invalid API action given" unless @@PLACES_API.keys.member?(action)
    TwitPic::API.query(self, @@PLACES_API[action], args)
  end  
  
end

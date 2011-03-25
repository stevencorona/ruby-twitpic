### Added by Clipflakes

class TwitPic::Client
  @@MEDIA_API = {
    :show => {
      :endpoint => 'media/show',
      :method => :get,
      :required => [:id]
    }
  }
  
  def media(action, args)
    raise ArgumentError, "Invalid API action given" unless @@MEDIA_API.keys.member?(action)
    TwitPic::API.query(self, @@MEDIA_API[action], args)
  end
  
end

class TwitPic::Client
  @@USERS_API = {
    :show => {
      :endpoint => 'users/show',
      :method => :get,
      :required => [:username]
    }
  }
  
  def users(action, args)
    raise ArgumentError, "Invalid API action given" unless @@USERS_API.keys.member?(action)
    TwitPic::API.query(self, @@USERS_API[action], args)
  end
  
end

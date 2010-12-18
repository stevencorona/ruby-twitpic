class TwitPic::Client
  @@COMMENTS_API = {
    :show => {
      :endpoint => 'comments/show',
      :method => :get,
      :required => [:media_id, :page]
    },
    
    :create => {
      :endpoint => 'comments/create',
      :method => :post,
      :required => [:media_id, :message]
    },
    
    :delete => {
      :endpoint => 'comments/delete',
      :method => :post,
      :required => [:comment_id]
    }
  }
  
  def comments(action, args)
    raise ArgumentError, "Invalid API action given" unless @@COMMENTS_API.keys.member?(action)
    TwitPic::API.query(self, @@COMMENTS_API[action], args)
  end
  
end

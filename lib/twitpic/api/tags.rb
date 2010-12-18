class TwitPic::Client
  @@TAGS_API = {
    :show => {
      :endpoint => 'tags/show',
      :method => :get,
      :required => [:tag]
    },
    
    :create => {
      :endpoint => 'tags/create',
      :method => :post,
      :required => [:media_id, :tags]
    },
    
    :delete => {
      :endpoint => 'tags/delete',
      :method => :post,
      :required => [:media_id, :tag_id]
    }
  }
  
  def tags(action, args)
    raise ArgumentError, "Invalid API action given" unless @@TAGS_API.keys.member?(action)
    TwitPic::API.query(self, @@TAGS_API[action], args)
  end
  
end

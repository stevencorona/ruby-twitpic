class TwitPic::Client
  @@FACES_API = {
    :show => {
      :endpoint => 'faces/show',
      :method => :post,
      :required => [:user]
    },
    
    :create => {
      :endpoint => 'faces/create',
      :method => :post,
      :required => [:media_id, :top_coord, :left_coord]
    },
    
    :edit => {
      :endpoint => 'faces/edit',
      :method => :post,
      :required => [:tag_id]
    },
    
    :delete => {
      :endpoint => 'faces/delete',
      :method => :post,
      :required => [:tag_id]
    }
  }
  
  def faces(action, args)
    raise ArgumentError, "Invalid API action given" unless @@FACES_API.keys.member?(action)
    TwitPic::API.query(self, @@FACES_API[action], args)
  end
  
end

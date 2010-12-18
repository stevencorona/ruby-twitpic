class TwitPic::Client
  @@EVENTS_API = {
    :show => {
      :endpoint => 'events/show',
      :method => :get,
      :required => [:user]
    }
  }
  
  @@EVENT_API = {
    :show => {
      :endpoint => 'event/show',
      :method => :get,
      :required => [:id]
    },
    
    :create => {
      :endpoint => 'event/create',
      :method => :post,
      :required => [:name]
    },
    
    :delete => {
      :endpoint => 'event/delete',
      :method => :post,
      :required => [:event_id]
    },
    
    :add => {
      :endpoint => 'event/add',
      :method => :post,
      :required => [:media_id, :event_id]
    },
    
    :remove => {
      :endpoint => 'event/add',
      :mehtod => :post,
      :required => [:event_id, :media_id]
    }
  }
  
  def events(action, args)
    raise ArgumentError, "Invalid API action given" unless @@EVENTS_API.keys.member?(action)
    TwitPic::API.query(self, @@EVENTS_API[action], args)
  end
  
  def event(action, args)
    raise ArgumentError, "Invalid API action given" unless @@EVENT_API.keys.member?(action)
    TwitPic::API.query(self, @@EVENT_API[action], args)
  end
  
end

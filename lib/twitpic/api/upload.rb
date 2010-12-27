class TwitPic::Client
  
  # Uploads a photo to TwitPic
  def upload(file, message)
  	message = "" unless message.strip.length > 0
  	
    TwitPic::API.upload(self, file, {:message => message})
  end
  
  def upload_and_post(file, args)
  	# Not finished yet, coming soon!
  	raise NotImplementedError, "The uploadAndPost API isn't implemented yet."
  	
  	link = TwitPic::API.upload(self, file, args)
  	if link then
  		TwitPic::API.tweet(self, args[:message], link)
  	end
  end
  
end

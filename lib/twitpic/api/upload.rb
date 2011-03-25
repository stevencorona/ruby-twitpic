class TwitPic::Client
  
  # Uploads a photo to TwitPic
  def upload(file, message)
    message = "" unless message.strip.length > 0
    
    TwitPic::API.upload(self, file, {:message => message})
  end
  
  def upload_and_post(file, message)
    message = "" unless message.strip.length > 0
    
    media = TwitPic::API.upload(self, file, {:message => message})
    if media then
      TwitPic::API.tweet(self, media)
    end
  end
  
end

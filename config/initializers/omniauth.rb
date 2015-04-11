Rails.application.config.middleware.use OmniAuth::Builder do  
 provider :vkontakte, '4806306', 'UIbra1bqr1bkR1NlFuy2',
 	{
      :scope => 'friends,audio,photos,email,notify',
      :display => 'popup',
      :lang => 'en',
      :image_size => 'original'
    }  
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'],  
  {
      :secure_image_url => 'true'
  }
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :image_size => 'large', :secure_image_url => true 
  provider :identity, fields: [:email, :name], model: User, on_failed_registration: lambda { |env|      
    UsersController.action(:new).call(env)  
  }
  
  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
  
end
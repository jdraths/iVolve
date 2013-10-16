Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, 'iA0zWYfLeg2aWA35cxi5g', 'S0GVADK1a4HGjp9QgVKydKn7YgetC0uHLtqScNa0'
  #provider :google_oauth2, 
  #provider :facebook,
  provider :identity, fields: [:email, :name], model: User, on_failed_registration: lambda { |env|
  	UsersController.action(:new).call(env)
  }

  OmniAuth.config.logger = Rails.logger
end
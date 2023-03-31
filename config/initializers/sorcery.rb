Rails.application.config.sorcery.submodules = [:reset_password, :external]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  
  config.external_providers = [:twitter]
  config.twitter.key = ENV['TWITTER_KEY']
  config.twitter.secret = ENV['TWITTER_SECRET_KEY']
  config.twitter.callback_url = Settings.sorcery[:callback_url]
  config.twitter.user_info_path = "/1.1/account/verify_credentials.json?include_email=true"
  config.twitter.user_info_mapping = {
    user_name: 'name',
    email: 'email'
  }
  config.user_config do |user|
    
    user.stretches = 1 if Rails.env.test?

    
    user.reset_password_mailer = UserMailer

    user.authentications_class = Authentication
  end

  config.user_class = "User"  
end

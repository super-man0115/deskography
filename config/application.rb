require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Deskography
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
  
    config.generators do |g|
      g.skip_routes true
      g.assets false
      g.helper false
      g.test_framework  :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: false
      g.factory_bot false
    end

    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]
    config.time_zone = 'Tokyo'
  end  
end

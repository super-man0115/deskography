source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "sorcery"
gem "rails-i18n"
gem "enum_help"
gem "draper"
gem "config"
gem "image_processing"
gem "dotenv"
gem "faker"


group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem "web-console"
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'rubocop', require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem 'letter_opener_web'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use postgres
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# User JWTSession with Devise
gem 'devise-jwt'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'rack-proxy', '~> 0.6.4'

# background jobs
gem 'sucker_punch'

# image processing
gem 'mini_magick'

gem 'omniauth-google-oauth2'
# fix for csrf warning, mmore info: https://github.com/omniauth/omniauth/wiki/Resolving-CVE-2015-9284
gem 'omniauth-rails_csrf_protection', '~> 0.1'
# fix https://stackoverflow.com/questions/60527005/adding-devise-jwt-to-a-rails-api-how-to-resolve-issue-while-generating-model
gem 'dry-configurable', '0.9.0'
gem 'pundit'
gem 'acts-as-taggable-on', '~> 6.0'

group :development, :test do
  gem 'rb-readline'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'annotate'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'listen'
  gem 'pry-byebug', '~> 3.4'
  gem 'pry-rails', '~> 0.3.4'
  gem 'rspec-rails', '~> 3.7'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

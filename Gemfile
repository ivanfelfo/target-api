# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'

gem 'activeadmin', '~> 2.9.0'
gem 'devise', '~> 4.7.3'
gem 'devise_token_auth', '~> 1.1.5'
gem 'geokit-rails', '~> 2.3.2'
gem 'onesignal-ruby', '~> 0.5.0'
gem 'rubocop-rails', '~> 2.9.1', require: false
gem 'sassc-rails', '~> 2.1.2'
gem 'sidekiq', '~> 6.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~>  6.1.0'
  gem 'faker', '~> 2.17.0'
  gem 'mailcatcher', '~> 0.2.4'
  gem 'pagy', '~> 4.5.1'
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop-rootstrap', '~> 1.2'
  gem 'shoulda-matchers', '~>  4.5.1'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'brakeman', '~> 5.0.0'
  gem 'spring', '~> 2.1.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.0.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.4", ">= 6.1.4.1"
# Use sqlite3 as the database for Active Record
#
# Use Puma as the app server
gem "puma", "~> 5.6", ">= 5.6.4"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"
# for api
gem "rack-cors"
# nokogiri
gem "nokogiri", ">= 1.12.5"
# spec
gem "rspec-rails", ">= 5.0.2"
# pry debugger
gem "pry"
# dirscord bot
gem "discordrb-webhooks"
# json web token
gem "jwt"
# rubocop linter
gem "rubocop", "~> 1.22", require: false
gem "rubocop-rails", require: false
gem "rubocop-rspec", require: false

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

group :production do
  gem "mysql2", "~> 0.5.2"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'activerecord-import'
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem 'doorkeeper', '~> 5.6'
gem 'doorkeeper-i18n'
gem 'rubyzip'
gem 'swagger-blocks'
gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 4.8'
  gem 'faker'
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  gem 'annotate'
  gem 'rubocop'
end

group :production do
  # gem 'mysql2', '~> 0.5.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

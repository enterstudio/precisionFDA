source 'https://rubygems.org'

# Bundler. The tool that manages all of our gems
gem 'bundler', '1.13.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.4.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Turnout gem is used to manage maintenance pages
gem 'turnout', '~> 2.2.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 4.1.0'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '>= 2.5.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Annotate models
gem 'annotate', '~> 2.6.6'

# Support for OR queries (needed for UserFile.accessible_by)
gem 'activerecord_any_of'

# Parameter validation for the API
gem 'rails_param'

# WiceGrid is a Rails grid plugin: https://github.com/leikind/wice_grid
gem "wice_grid", ">= 3.6.2"

# Page-specific javascript for Rails done right
gem "paloma", "5.0.0"

# Websocket support (for fetching logs)
gem "websocket"

# Semantic versioning parsing
gem "semverly"

# Captcha
gem "humanizer"

# Excel spreadsheet generation
gem 'axlsx'

# Secure headers
gem 'secure_headers'

# Gravatar profile image helper
gem 'gravtastic'

# Adds pagination support to models
gem 'kaminari', '>= 0.17.0'
gem 'bootstrap-kaminari-views', '>= 0.0.5'


# Add comments on any model
gem 'acts_as_commentable_with_threading'
gem 'acts_as_votable'
gem 'acts_as_follower'
gem 'acts-as-taggable-on'

# For inline-css in emails
gem 'inky-rb', require: 'inky'
gem 'nokogiri'
gem 'premailer-rails', '>= 1.9.4'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.3', '>= 2.3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Use thin
  gem 'thin'

  # Manage environment variables
  gem 'figaro'
end

group :production do
  gem 'mysql2', '~> 0.3.18'
  # Use Unicorn as the app server
  gem 'unicorn', '~> 4.9.0'
  gem 'exception_notification', '4.1.1'
end

source 'https://rubygems.org'

ruby '2.1.5'
gem 'rails', '4.1.4'
gem 'sass-rails', '4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'rails-api' , require: 'rails-api/action_controller/api'
gem 'sdoc', require: false, group: :doc
gem "pry"
gem 'awesome_print'

#Omniauth
gem 'omniauth'
gem 'omniauth-facebook'
gem 'devise'
gem 'doorkeeper'
gem 'warden'
gem 'fb_graph'
gem 'protected_attributes'

# Amazon S3
gem "paperclip"
gem "aws-sdk"
gem 'aws-s3'
gem 'mail'
gem 'mandrill-api', :require => 'mandrill' 
gem 'newrelic_rpm'

group :test, :development do
  gem "rspec-rails"
  # gem "selenium-webdriver"
  gem "better_errors"
  # gem "binding_of_caller"
  gem "factory_girl_rails"
  # gem "simplecov"
  gem 'annotate'
  gem "database_cleaner"
  gem "sqlite3"
  # gem "guard-rspec", require: false
  gem "thin"
end

group :production do
  gem "pg"
  gem "google-analytics-rails"
  gem "rails_12factor"
end

# Makes forms prettier
# gem 'simpleform'

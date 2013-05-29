source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
    gem "railroady", "~> 1.1.0"
    gem 'pry'
    gem 'pry-debugger'
end
group :development,:production do
  gem 'devise'
  gem 'twitter-bootstrap-rails'
  gem 'cancan'
  gem 'thin'
  gem 'mysql2'
  gem 'paperclip'
  gem 'awesome_nested_set'
  gem "rolify", ">= 3.2.0"
  gem "simple_form", ">= 2.0.4"
  gem 'jquery-rails'
  gem "jquery-ui-rails", "~> 4.0.1"
  gem 'vestal_versions', :git => 'git://github.com/laserlemon/vestal_versions'
end  
group :production do
  gem 'passenger'
end
group :test do
  gem "database_cleaner", ">= 0.9.1"
  gem "email_spec", ">= 1.4.0"
end

gem "rspec-rails", ">= 2.12.2", :group => [:development, :test]
gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false

# Gems used only for assets and not required
# in production environments by default.
group :assets do
   gem 'sass-rails',   '~> 3.2.3'
  #gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'bootstrap-sass'
  gem 'uglifier', '>= 1.0.3'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'


source 'http://rubygems.org'
gem 'rails', '3.0.0'
gem 'acts_as_list'
gem 'mysql'
gem 'delayed_job', '2.1.0.pre'
gem 'nice_password'
gem "will_paginate", "3.0.pre"
gem 'paperclip'
gem 'capistrano'
gem 'capistrano-ext'
gem 'jammit'
gem "exception_notification", :git => "http://github.com/rails/exception_notification.git", :require => 'exception_notifier'

group :development do 
  gem 'thin'
  gem 'rspec' 
  gem "rspec-rails", ">= 2.0.0.beta.22"
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'pickle'
  gem 'spork', "0.9.0.rc2"
  gem 'launchy'    # So you can do Then show me the page
  gem 'email_spec', "1.0.0"
end

group :test do
  gem 'rspec' 
  gem "rspec-rails", ">= 2.0.0.beta.22"
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'pickle'
  gem 'spork', "0.9.0.rc2"
  gem 'launchy'    # So you can do Then show me the page
  gem 'email_spec', "1.0.0"
  gem 'factory_girl_rails'
end

group :after_initialize do
    gem "feedzirra"
end


source "https://rubygems.org"
ruby "2.1.5"

gem "rails", "~> 4.2.0"

# Bundle edge Rails instead:
# gem "rails", :git => "git://github.com/rails/rails.git"
gem "devise"
gem "omniauth"
gem "omniauth-google-oauth2" 
gem "pg"
gem "activerecord-session_store"
gem "high_voltage"
gem "cancancan"
gem "dotenv-rails"

# Payments
gem "balanced"
gem "stripe"

gem "faraday", "~> 0.8.6"

gem "resque", branch: "1-x-stable", github: "resque/resque"
gem "resque-web", require: "resque_web"
gem "redis"
gem "foreman"

# Gems used only for assets and not required
# in production environments by default.
gem "sass-rails"
gem "coffee-rails"
gem "font-awesome-sass", "~> 4.3.0"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem "therubyracer", :platforms => :ruby

gem "uglifier"

gem "bitters"
gem "bourbon"
gem "neat"

gem "kaminari"
gem "mandrill_mailer"

gem "email_validator"

group :development do 
  gem "byebug"
  gem "pry-byebug"
  gem "better_errors"
end

group :development, :test do
  gem "faker"
  gem "database_cleaner"
  gem "guard-rails"
  gem "guard-rspec"
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.0"
  gem "shoulda-matchers"
  gem "spring"
  gem "stripe-ruby-mock", "~> 2.1.0", :require => "stripe_mock"
  gem "vcr"
end

gem "jquery-rails"


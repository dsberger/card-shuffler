source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.2.4'

# Front End
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.0'
gem 'bower-rails'
gem 'angular_rails_csrf'


group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'jasmine-rails'
end

group :test do
  gem "database_cleaner", "~> 1.3.0"
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

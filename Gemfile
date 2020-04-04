ruby '~> 2.6'

source 'https://rubygems.org' do
  gem 'grape' # Web API
  # gem 'sqlite3' # DB
  gem 'pg' # DB
  gem 'sequel' # ORM
  gem 'rake' # Automated tasks
  gem 'dry-monads' # Service Ruby Objects "Railway Oriented Programming"

  group :test do
    gem 'rspec'
    gem 'rack-test', require: 'rack/test'
  end

  group :development, :test do
    gem 'rubocop', require: false
    gem 'pry'
    gem 'dotenv'
  end
end

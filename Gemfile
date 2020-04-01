ruby '~> 2.6'

source 'https://rubygems.org' do
  gem 'grape' # Web API
  gem 'sequel' # ORM
  gem 'sqlite3' # DB
  gem 'rake' # Automated tasks
  gem 'dry-monads' # Service Ruby Objects

  group :development do
    gem 'pry'
  end

  group :test do
    gem 'rspec'
    gem 'rack-test', require: 'rack/test'
  end

  group :development, :test do
    gem 'rubocop', require: false
  end
end

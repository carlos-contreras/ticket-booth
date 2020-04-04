$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

# require 'sequel'
require_relative '../db/config'

db_url = Database.url(ENV['RACK_ENV'])
puts "connecting to database: #{db_url}"
Sequel::Model.db = Sequel.connect(db_url)

Dir[File.expand_path('../app/api/*.rb', __dir__)].each do |f|
  require f
end

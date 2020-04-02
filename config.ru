$:.unshift(File.expand_path('..', __FILE__))

require 'bundler'
Bundler.require(:default, :test)

require 'db/config'
require 'app/api/ticket_booth'

Sequel::Model.db = Sequel.connect(Database.url('dev'))

TicketBooth::API.compile!

puts('Init Ticket Booth API...')

run TicketBooth::API

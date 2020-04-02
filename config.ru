$:.unshift(File.expand_path('..', __FILE__))

require 'bundler'
Bundler.require(:default, :development)

require 'db/config'
Sequel::Model.db = Sequel.connect(Database.url('dev'))

require 'app/api/ticket_booth'

TicketBooth::API.compile!

puts('Init Ticket Booth API...')

run TicketBooth::API

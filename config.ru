$:.unshift(File.expand_path('..', __FILE__))

require 'app/api/ticket_booth'

TicketBooth::API.compile!

puts('Init Ticket Booth API...')

run TicketBooth::API

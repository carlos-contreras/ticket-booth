require './app/api/cinema_api.rb'

TicketBooth::API.compile!

puts('Init Ticket Booth API...')

run TicketBooth::API

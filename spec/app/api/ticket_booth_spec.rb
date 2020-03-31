require 'spec_helper'
require './app/api/ticket_booth.rb'

describe TicketBooth::API do
  include Rack::Test::Methods

  def app
    TicketBooth::API
  end

  context 'GET /api/movies' do
    it 'returns expected response' do
      get '/api/movies'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({ "carlos" => true })
    end
  end
  context 'GET /api/reservations' do
    it 'returns expected response' do
      get '/api/reservations'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to eq({ "carlos" => true })
    end
  end
end
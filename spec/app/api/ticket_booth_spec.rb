require 'spec_helper'
require 'app/api/ticket_booth'

describe TicketBooth::API do
  include Rack::Test::Methods

  def app
    TicketBooth::API
  end

  describe 'GET /api/movies' do
    context 'when no movie is found' do
      it 'returns expected response' do
        get '/api/movies', day: 'monday'
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end
    context 'when there are movies for that day' do
      before do
        Movie.create(
          title: "Test Movie",
          description: "Test description",
          image_url: "http://test-movie.com/poster.jpg",
          monday: true
        )
      end

      it 'returns expected response' do
        get '/api/movies', day: 'monday'
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([Movie.first.to_hash.transform_keys!(&:to_s)])
      end
    end
  end

  describe 'GET /api/reservations' do
    let(:start_date) { 2.days.ago.strftime("%Y-%m-%d") }
    let(:end_date) { 2.days.from_now.strftime("%Y-%m-%d") }

    context 'when no reservation is found' do
      it 'returns expected response' do
        get '/api/reservations', start_date: start_date, end_date: end_date
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq([])
      end
    end

    context 'when there are reservations within date range' do
      before do
        Movie.create(
          title: "Test Movie",
          description: "Test description",
          image_url: "http://test-movie.com/poster.jpg",
          monday: true,
          tuesday: true,
          wednesday: true,
          thursday: true,
          friday: true,
          saturday: true,
          sunday: true
        )
        Reservation.create(
          movie_id: Movie.first.id,
          date: 1.days.from_now,
          customer_name: "Jhon Doe",
          customer_phone: "555 555 5555"
        )
        Reservation.create(
          movie_id: Movie.first.id,
          date: 1.days.ago,
          customer_name: "Jhon Doe",
          customer_phone: "555 555 5555"
        )
      end

      let(:expected_response) do
        first_reservation = Reservation.first.to_hash.transform_keys!(&:to_s)
        first_reservation["date"] = first_reservation["date"].to_s
        last_reservation = Reservation.last.to_hash.transform_keys!(&:to_s)
        last_reservation["date"] = last_reservation["date"].to_s
        [first_reservation, last_reservation]
      end

      it 'returns expected response' do
        get '/api/reservations', start_date: start_date, end_date: end_date
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq(expected_response)
      end
    end
  end
end

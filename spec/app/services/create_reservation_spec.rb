require "spec_helper"
require "app/services/create_reservation"

describe Service::CreateReservation do
  let(:subject) do
    described_class.new.call(params)
  end
  let(:first_movie) do
    Movie.create(
      title: "Test Movie",
      description: "Test description.",
      image_url: "http://test-movie.com/poster.jpg",
      friday: true,
    )
  end

  context 'when record can be created' do
    let(:params) do
      {
        movie_id: first_movie.id,
        date: '2020-04-03',
        customer_name: "Jhon Doe",
        customer_phone: "555 555 5555"
      }
    end

    it 'creates a record' do
      expect(subject.success).to be_an_instance_of(Reservation)
    end
  end

  context 'when the related movie does not present on the given date' do
    let(:params) do
      {
        movie_id: first_movie.id,
        date: '2020-04-04',
        customer_name: "Jhon Doe",
        customer_phone: "555 555 5555"
      }
    end

    it 'returs errors' do
      expect(subject.failure[:errors]).to match(described_class::ERRORS[:movie_not_available_on_date])
    end
  end

  context 'when the related movie does not exists' do
    let(:params) do
      {
        movie_id: "999",
        date: '2020-04-04',
        customer_name: "Jhon Doe",
        customer_phone: "555 555 5555"
      }
    end

    it 'returs errors' do
      expect(subject.failure[:errors]).to match(described_class::ERRORS[:movie_not_found])
    end
  end

  context 'when the related movie is full for the date' do
    let(:params) do
      {
        movie_id: first_movie.id,
        date: '2020-04-03',
        customer_name: "Jhon Doe",
        customer_phone: "555 555 5555"
      }
    end

    before do
      10.times do |idx|
        Reservation.create(
          {
            movie_id: first_movie.id,
            date: '2020-04-03',
            customer_name: "Customer #{idx}",
            customer_phone: "555 555 555#{idx}"
          }
        )
      end
    end

    it 'returs errors' do
      expect(subject.failure[:errors]).to match(described_class::ERRORS[:movie_function_full])
    end
  end

  context 'when customer already booked on that movie function' do
    let(:params) do
      {
        movie_id: first_movie.id,
        date: '2020-04-03',
        customer_name: "Jhon Doe",
        customer_phone: "555 555 5555"
      }
    end

    before do
      Reservation.create(
        movie_id: first_movie.id,
        date: '2020-04-03',
        customer_name: "Jhon Doe",
        customer_phone: "555 555 5555"
      )
    end

    it 'returs errors' do
      expect(subject.failure[:errors]).to match(described_class::ERRORS[:customer_already_booked])
    end
  end
end

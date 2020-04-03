require "spec_helper"
require "app/models/reservation"

describe Reservation do
  before do
    Movie.create(
      title: "Test Movie",
      description: "Test description",
      image_url: "http://test-movie.com/poster.jpg"
    )
  end

  let(:subject) do
    described_class.new(
      movie_id: Movie.first.id,
      date: 2.days.from_now,
      customer_name: "Jhon Doe",
      customer_phone: "555 555 5555"
    )
  end

  it 'creates a record' do
    expect { subject.save }.to change { described_class.count }.from(0).to(1)
  end
end

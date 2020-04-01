require "spec_helper"
require "app/models/reservation"

describe Reservation do
  before do
    Movie.create(
      name: "Arrival",
      description: "Louise Banks, a linguistics expert, along with her team, must interpret the language of aliens who've come to earth in a mysterious spaceship.",
      image_url: "https://en.wikipedia.org/wiki/Arrival_(film)#/media/File:Arrival,_Movie_Poster.jpg"
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

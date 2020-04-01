require 'spec_helper'
require 'app/models/movie'

describe Movie do
  let(:subject) do
    described_class.new(
      name: "Arrival",
      description: "Louise Banks, a linguistics expert, along with her team, must interpret the language of aliens who've come to earth in a mysterious spaceship.",
      image_url: "https://en.wikipedia.org/wiki/Arrival_(film)#/media/File:Arrival,_Movie_Poster.jpg"
    )
  end

  it 'creates a record' do
    expect { subject.save }.to change { described_class.count }.from(0).to(1)
  end
end

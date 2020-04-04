require 'spec_helper'
require 'app/models/movie'

describe Movie do
  let(:subject) do
    described_class.new(
      title: "Test Movie",
      description: "Test description",
      image_url: "http://test-movie.com/poster.jpg"
    )
  end

  it 'creates a record' do
    expect { subject.save }.to change { described_class.count }.from(0).to(1)
  end

  it 'finds created records' do
    expect { subject.save }.to change { described_class.first&.id }.from(nil).to(an_instance_of(Fixnum))
  end
end

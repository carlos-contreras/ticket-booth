require "spec_helper"
require "app/services/create_movie"

describe Service::CreateMovie do
  let(:subject) do
    described_class.new.call(params)
  end

  context 'when there are no errors' do
    let(:params) do
      {
        name: "Test movie",
        description: "Test Description",
        image_url: "https://testmoviecovers/test_image.jpg"
      }
    end

    it 'creates a record' do
      expect(subject.success).to be_instance_of(Movie)
    end
  end

  context 'when there wrong params' do
    let(:params) do
      { wrong_param: "Test movie", }
    end

    it 'creates a record' do
      expect(subject.success).to be_falsey
      expect(subject.failure).to be_instance_of(Sequel::MassAssignmentRestriction)
    end
  end
end

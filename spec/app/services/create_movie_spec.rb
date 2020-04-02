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

    it 'returns a db record' do
      expect(subject.success).to be_instance_of(Movie)
    end
  end

  context 'when there wrong params' do
    let(:params) do
      { wrong_param: "Test movie" }
    end

    it 'fails to build the db record' do
      expect(subject.success).to be_falsey
    end
    it 'returns a hash with errors' do
      expect(subject.failure).to include(:errors)
    end
  end

  context 'when there are missing params' do
    let(:params) do
      {  name: "Test movie" }
    end

    it 'fails to build the db record' do
      expect(subject.success).to be_falsey
    end
    it 'returns a hash with errors' do
      expect(subject.failure).to include(:errors)
    end
  end
end

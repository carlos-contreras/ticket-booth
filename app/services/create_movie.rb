
require 'app/models/movie'
require 'dry/monads/all'

module Service
  class CreateMovie
    include Dry::Monads
    include Dry::Monads::Do.for(:call)

    def call(params)
      validated_data = yield validate(params)
      persist(validated_data)
    end

    def validate(params)
      Try(Sequel::MassAssignmentRestriction) {
        new_model = Movie.new(params)
        return Success(new_model) if new_model.valid?
        Failure(new_model.errors)
      }.to_result.bind do |result|
        if result.failure?
          Failure({ error: result.failure.message })
        else
          Success(result.success)
        end
      end
    end

    def persist(movie)
      return Success(movie) if movie.save
      Failure(movie.errors)
    end
  end
end
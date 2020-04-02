
require 'app/models/movie'
require 'dry/monads/all'

module Service
  class CreateMovie
    include Dry::Monads
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:call)

    def call(params)
      validated_data = yield validate(params)
      persist(validated_data)
    end

    private

    def validate(params)
      assignment = Try(Sequel::MassAssignmentRestriction) { Movie.new(params) }.to_result
      if assignment.failure?
        Failure({ errors: assignment.failure.message })
      else
        new_model = assignment.value!
        return Success(new_model) if new_model.valid?
        Failure({ errors: new_model.errors })
      end
    end

    def persist(movie)
      return Success(movie) if movie.save
      Failure({ errors: movie.errors.message })
    end
  end
end
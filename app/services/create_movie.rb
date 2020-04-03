require 'app/models/movie'
require 'dry/monads/all'

module Service
  class CreateMovie
    include Dry::Monads
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:call)

    ERRORS = {
      movie_already_exist: "A movie with that title already exist.",
      title_is_required: "A movie must have a title."
    }.freeze

    def call(params)
      sanitized_params = yield sanitize_params(params)
      validated_model = yield validate(sanitized_params)
      persist(validated_model)
    end

    private

    def sanitize_params(params)
      return Failure(errors: ERRORS[:title_is_required]) if !params[:title]
      params[:title] = params[:title].downcase
      if Movie.first(title: params[:title])
        return Failure({ errors: ERRORS[:movie_already_exist] })
      else
        return Success(params)
      end
    end

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

    def persist(model)
      return Success(model) if model.save
      Failure({ errors: model.errors.message })
    end
  end
end
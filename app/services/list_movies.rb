require 'app/models/movie'
require 'dry/monads/all'

module Service
  class ListMovies
    include Dry::Monads
    include Dry::Monads::Do.for(:call)

    VALID_DAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

    def call(params)
      query = yield validate(params[:day])
      get_records(query)
    end

    private

    def validate(day)
      if VALID_DAYS.include?(day)
        Success({ day.to_sym => true })
      else
        Failure({ errors: "#{day} is not a valid day, use any of #{VALID_DAYS.to_s}" })
      end
    end

    def get_records(query)
      Success(Movie.where(query))
    end
  end
end
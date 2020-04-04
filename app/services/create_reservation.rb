require 'dry/monads/all'
require_relative '../models/movie'
require_relative '../models/reservation'

module Service
  class CreateReservation
    include Dry::Monads
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:call)

    DAY_METHODS = %w[monday? tuesday? wednesday? thursday? friday? saturday? sunday?].freeze
    ERRORS = {
      movie_not_found: "The movie was not found.",
      movie_not_available_on_date: "The movie does not have a function for that date.",
      movie_function_full: "The movie function is full, try different date.",
      customer_already_booked: "The customer already booked for this movie function."
    }.freeze

    def call(params)
      @movie = Movie.first(id: params[:movie_id])
      validated_model = yield validate(params)
      validated_model = yield check_constraints(validated_model)
      persist(validated_model)
    end

    private

    def validate(params)
      return Failure({ errors: ERRORS[:movie_not_found] }) if @movie.nil?
      params[:date] = params[:date] && Date.strptime(params[:date], "%Y-%m-%d")
      assignment = Try(Sequel::MassAssignmentRestriction) { Reservation.new(params) }.to_result
      if assignment.failure?
        Failure({ errors: assignment.failure.message })
      else
        new_model = assignment.value!
        return Success(new_model) if new_model.valid?
        Failure({ errors: new_model.errors })
      end
    end

    def check_constraints(model)
      existing_reservations_for_movie =
        Reservation.where(
          date: model.date,
          movie_id: model.movie_id
        ).count
      if existing_reservations_for_movie >= 10
        return Failure({ errors: ERRORS[:movie_function_full] })
      end
      existing_reservations_for_user =
        Reservation.where(
          customer_phone: model.customer_phone,
          movie_id: model.movie_id,
          date: model.date
        ).count
      if existing_reservations_for_user >= 1
        return Failure({ errors: ERRORS[:customer_already_booked] })
      end
      unless movie_presents_on_date(model.date, model.movie_id)
        return Failure({ errors: ERRORS[:movie_not_available_on_date] })
      end

      Success(model)
    end

    def movie_presents_on_date(date, movie_id)
      day_of_week = DAY_METHODS.find { |day_method| date.send(day_method) }.delete("?")
      @movie.send(day_of_week)
    end

    def persist(model)
      return Success(model) if model.save
      Failure({ errors: model.errors.message })
    end
  end
end

require 'app/models/reservation'
require 'dry/monads/all'

module Service
  class CreateReservation
    include Dry::Monads
    include Dry::Monads::Do.for(:call)

    def call(params)
      validated_data = yield validate(params)
      persist(validated_data)
    end

    def validate(params)
      new_model = Reservation.new(params)
      return Success(new_model) if new_model.valid?
      Failure(new_model.errors)
    end

    def persist(reservation)
      return Success(reservation) if reservation.save
      Failure(reservation.errors)
    end
  end
end

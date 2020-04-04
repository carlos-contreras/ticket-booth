require 'dry/monads/all'
require_relative '../models/movie'
require_relative '../models/reservation'

module Service
  class ListReservations
    include Dry::Monads
    include Dry::Monads::Do.for(:call)

    ERRORS = {
      invalid_format: "Invalid date format on input valid format is YYYY-MM-DD."
    }.freeze

    def call(params)
      query = yield validate(params)
      get_records(query)
    end

    private

    def validate(params)
      date_range = Try(ArgumentError) {
        start_date = Date.strptime(params[:start_date], "%Y-%m-%d")
        end_date = Date.strptime(params[:end_date], "%Y-%m-%d")
        (start_date...end_date)
      }.to_result

      if date_range.success?
        Success({ date: date_range.value! })
      else
        Failure({ errors: ERRORS["Invalid date format on input valid format is YYYY-MM-DD."] })
      end
    end

    def get_records(query)
      Success(Reservation.where(query))
    end

    def get_date_object(date_str)
      Date.strptime(date_str, "%Y-%m-%d")
    end
  end
end
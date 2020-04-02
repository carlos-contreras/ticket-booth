require 'app/services/create_movie'
require 'app/services/create_reservation'

module TicketBooth
  class API < Grape::API
    version 'v1', using: :header, vendor: 'cinema'
    format :json
    prefix :api

    helpers do
      def logger
        API.logger
      end
    end

    resource '/movies' do
      desc 'List movies given a day of the week'
      get do
        logger.info params.inspect
        { carlos: true }
        # List movies here
      end

      desc 'Create a movie given the movie data'
      params do
        requires :movie, type: Hash do
          requires :name, type: String
          requires :description, type: String
          requires :image_url, type: String
          optional :monday, type: Boolean, default: false
          optional :tuesday, type: Boolean, default: false
          optional :wednesday, type: Boolean, default: false
          optional :thursday, type: Boolean, default: false
          optional :friday, type: Boolean, default: false
          optional :saturday, type: Boolean, default: false
          optional :sunday, type: Boolean, default: false
        end
      end
      post do
        logger.info "POST /movies.json"
        result = Service::CreateMovie.new.call(declared(params)[:movie])

        if result.success?
          result.value!.to_hash
        else
          result.failure
        end
      end
    end

    resource '/reservations' do
      desc 'List reservations given a date range'
      get do
        logger.info params.inspect
        { carlos: true }
        # List reservations here
      end

      desc 'Create a resvation for a movie given the day of the week and the movie'
      params do
        requires :reservation, type: Hash do
          requires :movie_id, type: Integer
          requires :date, type: String, regexp: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/
          requires :customer_name, type: String
          requires :customer_phone, type: String
        end
      end
      post do
        logger.info "POST /reservations.json"
        result = Service::CreateReservation.new.call(declared(params)[:reservation])

        if result.success?
          result.value!.to_hash
        else
          result.failure
        end
      end
    end
  end
end

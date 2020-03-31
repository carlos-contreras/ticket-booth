require 'grape'

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
      post do
        logger.info params.inspect
        { carlos: true }
        # Create the movie here
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
      post do
        logger.info params.inspect
        { carlos: true }
        # Create the reservation here
      end
    end
  end
end

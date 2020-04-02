# primary_key :id
# foreign_key :movie_id, :movie
# Date :date, null: false
# String :customer_name, null: false
# String :customer_phone, null: false

class Reservation < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence %i[movie_id date customer_name customer_phone]
  end
end

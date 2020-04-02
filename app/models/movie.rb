# primary_key :id
# String :name, null: false
# String :description, null: false
# String :image_url, null: false
# TrueClass :monday
# TrueClass :tuesday
# TrueClass :wednesday
# TrueClass :thursday
# TrueClass :friday
# TrueClass :saturday
# TrueClass :sunday

# require 'db/config'

# Sequel::Model.db = Sequel.connect(Database.url('dev'))

class Movie < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence %i[name image_url description]
  end
end

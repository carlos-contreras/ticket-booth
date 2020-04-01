# primary_key :id
# String :name, null: false
# String :description, null: false
# String :image_url, null: false
# TrueClass :monday
# TrueClass :tuesday
# TrueClass :wednesday
# TrueClass :thuesday
# TrueClass :friday
# TrueClass :saturday
# TrueClass :sunday

class Movie < Sequel::Model(:movies)
  plugin :validation_helpers

  def validate
    super
    validates_presence %i[name image_url description]
  end
end

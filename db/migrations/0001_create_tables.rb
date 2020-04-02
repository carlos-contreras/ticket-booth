Sequel.sqlite('ticket_booth.db')

Sequel.migration do
  up do
    create_table(:movies) do
      primary_key :id
      String :name, null: false
      String :description, null: false
      String :image_url, null: false
      TrueClass :monday
      TrueClass :tuesday
      TrueClass :wednesday
      TrueClass :thursday
      TrueClass :friday
      TrueClass :saturday
      TrueClass :sunday
    end

    create_table(:reservations) do
      primary_key :id
      foreign_key :movie_id, :movies
      Date :date, null: false
      String :customer_name, null: false
      String :customer_phone, null: false
    end
  end

  down do
    drop_table(:movies)
    drop_table(:reservations)
  end
end
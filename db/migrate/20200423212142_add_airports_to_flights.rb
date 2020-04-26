class AddAirportsToFlights < ActiveRecord::Migration[6.0]
  def change
    add_reference :flights, :to_airport, references: :airports, index: true
    add_reference :flights, :from_airport, references: :airports, index: true
  end
end

class AddFlightRefToBooking < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :flight, foreign_key: true
    change_column_null :bookings, :flight_id, false
  end
end

class AddBookingRefToPassengers < ActiveRecord::Migration[6.0]
  def change
    add_reference :passengers, :booking, foreign_key: true
    change_column_null :passengers, :booking_id, false
  end
end

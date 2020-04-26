class AddNullConstraintToFlights < ActiveRecord::Migration[6.0]
  def change
  	change_column_null :flights, :to_airport_id, false
  	change_column_null :flights, :from_airport_id, false
  end
end

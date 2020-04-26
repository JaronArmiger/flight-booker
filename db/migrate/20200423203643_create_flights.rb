class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.datetime :start_time
      t.integer :duration
      t.integer :to_airport
      t.integer :from_airport

      t.timestamps
    end
  end
end

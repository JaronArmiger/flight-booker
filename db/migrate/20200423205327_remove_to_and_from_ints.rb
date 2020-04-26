class RemoveToAndFromInts < ActiveRecord::Migration[6.0]
  def change
  	remove_column :flights, :to_airport, :integer
  	remove_column :flights, :from_airport, :integer
  end
end

class Flight < ApplicationRecord
	belongs_to :to_airport,   class_name: "Airport"
	belongs_to :from_airport, class_name: "Airport"
	has_one    :booking


	validates :start_time,   presence: true
	validates :duration,     presence: true
	validates :to_airport,   presence: true
	validates :from_airport, presence: true

	def self.get_start_times
		Flight.find_by_sql("select distinct start_time from flights order by start_time asc")
	end

	def formatted_start_time
		start_time.strftime("%m/%d/%Y %I:%M %p")
	end

	def self.find_flights(search_params)
		from_airport_id = search_params["from_airport_id"].to_i
		to_airport_id   = search_params["to_airport_id"].to_i
		date = Flight.assemble_date(search_params["date(1i)"],
								  search_params["date(2i)"],
								  search_params["date(3i)"])
		low_bound  = date - 15.days
		high_bound = date + 15.days
		Flight.where("from_airport_id = ? AND to_airport_id = ?
			          AND start_time >= ? AND start_time <= ?",
			          from_airport_id, to_airport_id,
			          low_bound, high_bound)
	end

	def self.assemble_date(year,month,day)
		DateTime.new(year.to_i,month.to_i,day.to_i)
	end
end

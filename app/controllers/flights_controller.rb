class FlightsController < ApplicationController
	def index
		@flight = Flight.new
		#@dates = Flight.get_start_times.format_date.uniq
		if params[:flight]
			@flights = Flight.find_flights(search_params)
		end
	end

	private

		def search_params
			params.require(:flight).permit(:from_airport_id,
										   :to_airport_id,
										   :num_tickets,
										   "date(1i)", "date(2i)",
										   "date(3i)")
		end
end

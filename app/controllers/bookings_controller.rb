class BookingsController < ApplicationController
	def index
		@bookings = Booking.all
	end

	def new

		@booking = Booking.new
		@flight = Flight.find(params[:flight_id].to_s)
		#@passengers = []
		count = params[:num_tickets].to_i
		count.times do
			@booking.passengers.build
		end
	end

	def create
		@booking = Booking.new(booking_params)
		if @booking.save
			redirect_to booking_path(@booking)
		end
	end

	def show
		@booking = Booking.find(params[:id])
		@flight = @booking.flight
	end

	private
		def booking_params
			params.require(:booking).permit(:flight_id,
				passengers_attributes: [:name, :email])
		end
end

require 'test_helper'

class FullAppTest < ActionDispatch::IntegrationTest
  def setup
  	@flight = flights(:one)
  end

  test "full booking process works" do
  	# search flights
  	get root_path
  	assert_template 'flights/index'
  	assert_response :success
  	assert_select 'form', count: 1
  	from = @flight.from_airport_id
  	to = @flight.to_airport_id
  	start_time = @flight.start_time
  	date_1 = start_time.year
  	date_2 = start_time.month
  	date_3 = start_time.day
  	get flights_path, params: { flight: {from_airport_id: from,
  										 to_airport_id: to,
  										 num_tickets: 3,
  										 "date(1i)" => date_1,
  										 "date(2i)" => date_2,
  										 "date(3i)" => date_3 } }
  	assert_select 'form', count: 2
  	assert_match @flight.to_airport.code, 	   response.body
  	assert_match @flight.from_airport.code,     response.body
  	assert_match @flight.id.to_s, 			   response.body
  	assert_match @flight.formatted_start_time, response.body
  	assert_match @flight.duration.to_s,		   response.body

  	# select flight

  	get new_booking_path, params: { flight_id: @flight.id,
  									num_tickets: 3}
  	assert_template 'bookings/new'
  	assert_select   'ul>li', count: 3

  	# submit Booking info
  	assert_difference 'Passenger.count', 3 do
  		post bookings_path, params: { booking: { flight_id: @flight.id, 
  								  passengers_attributes: { "0" => { 
  								 	name: "Andrea", email: "andrea@ask.fr" },
  								 	"1" => { name: "Camille", email: "camille@ask.fr"},
  								 	"2" => { name: "Arlette", email: "arlette@ask.fr"} } } }
  	end
  	booking = assigns(:booking)
  	assert_redirected_to booking_path(booking)
  	follow_redirect!
  	assert_template "bookings/show"

  end
end









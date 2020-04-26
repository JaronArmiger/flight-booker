require 'test_helper'

class SearchFlightsTest < ActionDispatch::IntegrationTest
  
  def setup
  	@flight = flights(:one)
  end

  test "search returns expected result" do
  	get root_path
  	assert_template 'flights/index'
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
  end
end

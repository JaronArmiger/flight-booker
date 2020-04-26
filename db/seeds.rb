codes = ['ATL', 'LAX', 'ORD', 'DFW', 'DEN', 'JFK', 'SFO', 
	     'LAS', 'SEA', 'CLT']

codes.each do |code|
	Airport.create(code: code)
end

600.times do
	from_airport_id = rand(10) + 1
	to_airport_id   = rand(10) + 1
	start_time = Time.now + rand(60).days + 1
	duration = rand(20) + 1
	Flight.create(start_time: start_time, duration: duration,
				  to_airport_id: to_airport_id, 
				  from_airport_id: from_airport_id)
end
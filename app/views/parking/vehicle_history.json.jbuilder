json.reservations @vehicle.parking_reservations do |reservation|
  json.extract! reservation, :id, :time, :paid, :left
end

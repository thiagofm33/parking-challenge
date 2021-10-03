json.reservations @vehicle.parking_reservations do |reservation|
  json.partial! 'parking_reservation', reservation: reservation
end

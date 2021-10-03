class ParkingController < ApplicationController

  def check_in
    @reservation = ParkingReservation.create_with_plate(params[:plate])

    unless @reservation.save
      render_errors @reservation.all_error_messages, :unprocessable_entity
    end
  end

end

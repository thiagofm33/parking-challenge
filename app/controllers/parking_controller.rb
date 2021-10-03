class ParkingController < ApplicationController
  before_action :get_vehicle, only: [:vehicle_history]

  def check_in
    @reservation = ParkingReservation.create_with_plate(params[:plate])

    unless @reservation.save
      render_errors @reservation.all_error_messages, :unprocessable_entity
    end
  end

  def vehicle_history
    render_errors({ vehicle: 'not found' }, :not_found) unless @vehicle
  end

  private

    def get_vehicle
      @vehicle = Vehicle.find_by_plate(params[:plate])
    end

end

class ParkingController < ApplicationController
  before_action :get_vehicle, only: [:vehicle_history]
  before_action :get_reservation, only: [ :check_out, :make_payment ]

  def check_in
    @reservation = ParkingReservation.create_with_plate(params[:plate])

    unless @reservation.save
      render_errors @reservation.all_error_messages, :unprocessable_entity
    end
  end

  def check_out
    update_reservation_time(:check_out_at)
  end

  def make_payment
    update_reservation_time(:paid_at)
  end

  def vehicle_history
    render_errors({ vehicle: 'not found' }, :not_found) unless @vehicle
  end

  private

    def update_reservation_time(field)
      if @reservation 
        if @reservation.update(field => Time.now)
          render :show
        else
          render_errors @reservation.errors.messages, :unprocessable_entity
        end
      else
        render_errors({ reservation: 'not found' }, :not_found)
      end
    end

    def get_vehicle
      @vehicle = Vehicle.find_by_plate(params[:plate])
    end

    def get_reservation
      @reservation = ParkingReservation.where(id: params[:id]).first
    end
end

class ParkingReservation < ApplicationRecord
  belongs_to :vehicle

  validates :vehicle, presence: true
  validates :check_in_at, presence: true

  validate :is_check_out_allowed?
  validate :vehicle_has_no_active_reservation?, on: :create

  #
  # Validation Methods
  #
  private

    def is_check_out_allowed?
      if check_out_at.present? and paid_at.blank?
        errors.add(:check_out_at, 'payment is pending')
      end
    end

    def vehicle_has_no_active_reservation?
      if vehicle.parking_reservations.where(check_out_at: nil).exists?
        errors.add(:vehicle, 'has an active reservation')
      end
    end
end

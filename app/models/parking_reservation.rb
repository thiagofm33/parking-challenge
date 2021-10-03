class ParkingReservation < ApplicationRecord
  belongs_to :vehicle

  validates_associated :vehicle
  validates :vehicle, presence: true
  validates :check_in_at, presence: true

  validate :is_check_out_allowed?
  validate :vehicle_has_no_active_reservation?, on: :create

  before_validation :prevent_time_change

  def self.create_with_plate(plate)
    vehicle = Vehicle.find_or_create_by(plate: plate)

    ParkingReservation.new(vehicle: vehicle, check_in_at: Time.now)
  end

  def all_error_messages
    errors.messages.merge(vehicle.errors.messages)
  end

  def time
    ((check_out_at || Time.now) - check_in_at).to_human_duration
  end

  def paid
    paid_at.present?
  end

  def left
    check_out_at.present?
  end

  private

    #
    # Validation Methods
    #

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

    #
    # Callback Methods
    #

    # It prevents the `check_out_at` and `paid_at` fields from being changed
    # after receiving non-null values.
    def prevent_time_change
      if paid_at_changed? and not paid_at_was.nil?
        restore_paid_at!
      end

      if check_out_at_changed? and not check_out_at_was.nil?
        restore_check_out_at!
      end
    end
end

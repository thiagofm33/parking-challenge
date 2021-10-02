class ParkingReservation < ApplicationRecord
  belongs_to :vehicle

  validates :vehicle, presence: true
  validates :check_in_at, presence: true

  validate :is_check_out_allowed?

  def is_check_out_allowed?
    if check_out_at.present? and paid_at.blank?
      errors.add(:check_out_at, 'payment is pending')
    end
  end
end

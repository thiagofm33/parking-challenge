class Vehicle < ApplicationRecord
  has_many :parking_reservations, -> { order(check_out_at: :desc) }

  enum vehicle_type: [ :car, :motorcycle ], _default: 0

  validates :plate,
    presence: true,
    uniqueness: true,
    format: { with: /\A[A-Z]{3}\-\d{4}\z/ }
end

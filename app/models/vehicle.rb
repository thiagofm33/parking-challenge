class Vehicle < ApplicationRecord
  has_many :parking_reservations

  enum vehicle_type: [ :car, :motorcycle ], _default: 0

  validates :plate,
    presence: true,
    uniqueness: true,
    format: { with: /\A[A-Z]{3}\-\d{4}\z/ }
end

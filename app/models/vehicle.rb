class Vehicle < ApplicationRecord

  enum vehicle_type: [ :car, :motorcycle ], _default: 0

  validates :plate, presence: true, format: { with: /\A[A-Z]{3}\-\d{4}\z/ }

end

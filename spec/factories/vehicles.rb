FactoryBot.define do
  factory :vehicle do
    plate { Faker::Vehicle.license_plate }
    vehicle_type { 0 } # Car
    make { Faker::Vehicle.make }
    model { Faker::Vehicle.model(make_of_model: make) }
    color { Faker::Vehicle.color }
  end
end

FactoryBot.define do
  factory :parking_reservation do
    vehicle { association(:vehicle) }
    check_in_at { 3.hours.ago }
    paid_at { nil }
    check_out_at { nil }

    trait :pending_payment do
      paid_at { nil }
    end

    trait :paid do
      paid_at { 1.hour.ago }
    end
  end
end

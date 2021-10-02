require 'rails_helper'

RSpec.describe ParkingReservation, type: :model do
  it { should belong_to(:vehicle) }
  it { should validate_presence_of(:vehicle) }
  it { should validate_presence_of(:check_in_at) }

  describe('`check_out_at` validation errors') do
    context('when updating the check_out_at field') do
      context('and the payment is PENDING') do
        let(:reservation) do
          FactoryBot.create(:parking_reservation, :pending_payment)
        end

        before { reservation.update(check_out_at: Time.now) }

        it { expect(reservation.errors[:check_out_at]).to include 'payment is pending' }
      end

      context('and the reservation is already PAID') do
        let(:reservation) { FactoryBot.create(:parking_reservation, :paid) }

        before { reservation.update(check_out_at: Time.now) }

        it { expect(reservation.errors[:check_out_at]).to be_empty }
      end
    end
  end

  describe('factory') do
    describe('`is_valid?`') do
      let(:parking_reservation) { FactoryBot.build(:parking_reservation) }
      it { expect(parking_reservation.valid?).to be true }
    end
  end
end

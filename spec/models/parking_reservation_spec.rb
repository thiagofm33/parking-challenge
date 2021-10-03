require 'rails_helper'

RSpec.describe ParkingReservation, type: :model do
  describe('Validations') do

    describe 'Basic validations' do
      subject { FactoryBot.create(:parking_reservation) }

      it { should belong_to(:vehicle) }
      it { should validate_presence_of(:vehicle) }
      it { should validate_presence_of(:check_in_at) }
    end

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

    context('when creating a reservation for a vehicle that already has an active reservation') do
      let(:vehicle) { FactoryBot.create(:vehicle) }
      let(:new_reservation) { FactoryBot.build(:parking_reservation, vehicle: vehicle) }
      before { FactoryBot.create(:parking_reservation, vehicle: vehicle) }

      it 'should not be valid and its errors should include "vehicle has an active reservation"' do
        expect(new_reservation).not_to be_valid
        expect(new_reservation.errors.messages[:vehicle]).to include 'has an active reservation'
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

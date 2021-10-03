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

  describe('Instance methods') do
    describe('time') do
      subject do
        FactoryBot.create(:parking_reservation, :paid, {
          check_in_at: 3.hours.ago,
          check_out_at: 30.minutes.ago
        })
      end

      it 'should return a humanized duration' do
        expect(subject.time).to eq '2 hours and 30 minutes'
      end
    end

    describe('paid') do
      let(:paid_reservation) { FactoryBot.create(:parking_reservation, :paid) }
      let(:not_paid_reservation) { FactoryBot.create(:parking_reservation) }

      it 'should return if the reservation was paid or not' do
        expect(paid_reservation.paid).to eq true
        expect(not_paid_reservation.paid).to eq false
      end
    end

    describe('left') do
      let(:finished_reservation) { FactoryBot.create(:parking_reservation, :left) }
      let(:active_reservation) { FactoryBot.create(:parking_reservation) }

      it 'should return if the reservation was paid or not' do
        expect(finished_reservation.left).to eq true
        expect(active_reservation.paid).to eq false
      end
    end
  end

  describe('Factory') do
    describe('`is_valid?`') do
      subject { FactoryBot.build(:parking_reservation) }
      it { expect(subject).to be_valid }
    end
  end
end

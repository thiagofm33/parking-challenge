require 'rails_helper'

RSpec.describe "Parkings", type: :request do
  let(:reservation) { FactoryBot.create(:parking_reservation, :left) }

  describe "POST /parking" do
    it "returns http success" do
      post check_in_path(plate: 'AAA-1111', format: :json)
      expect(response).to have_http_status(:success)
    end

    it "returns http unprocessable_entity if the plate is invalid" do
      post check_in_path(plate: 'AAA-111', format: :json)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /parking/:id/out" do
    it "returns http success" do
      patch check_out_path(reservation.id, format: :json)
      expect(response).to have_http_status(:success)
    end

    it "returns http not_found if the reservation does not exist" do
      patch check_out_path(3, format: :json)
      expect(response).to have_http_status(:not_found)
    end

    context("with a pending-payment reservation") do
      let(:reservation) { FactoryBot.create(:parking_reservation) }
      before { patch check_out_path(reservation.id, format: :json) }

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response.body).to include 'payment is pending' }
    end
  end

  describe "PATCH /make_payment" do
    it "returns http success" do
      patch pay_path(reservation.id, format: :json)
      expect(response).to have_http_status(:success)
    end

    it "returns http not_found if the reservation does not exist" do
      patch pay_path(3, format: :json)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /parking/:plate" do
    it "returns http success" do
      vehicle = FactoryBot.create(:vehicle)
      get history_path(plate: vehicle.plate, format: :json)
      expect(response).to have_http_status(:success)
    end

    it "returns http not_found if the vehicle does not exist" do
      get history_path(plate: 'AAA-0000')
      expect(response).to have_http_status(:not_found)
    end
  end

end

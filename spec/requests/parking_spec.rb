require 'rails_helper'

RSpec.describe "Parkings", type: :request do

  describe "POST /parking" do
    it "returns http success" do
      post check_in_path(plate: 'AAA-1111')
      expect(response).to have_http_status(:success)
    end

    it "returns http unprocessable_entity if the plate is invalid" do
      post check_in_path(plate: 'AAA-111')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /parking/:plate" do
    it "returns http success" do
      vehicle = FactoryBot.create(:vehicle)
      get history_path(plate: vehicle.plate)
      expect(response).to have_http_status(:success)
    end

    it "returns http not_found if the vehicle does not exist" do
      get history_path(plate: 'AAA-0000')
      expect(response).to have_http_status(:not_found)
    end
  end

end

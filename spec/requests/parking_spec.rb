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

end

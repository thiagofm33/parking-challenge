require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  before { FactoryBot.create(:vehicle) }

  it { should define_enum_for(:vehicle_type) }
  it { should validate_presence_of(:plate) }
  it { should validate_uniqueness_of(:plate) }
  it { should allow_value('RTV-1234').for(:plate) }
  it { should_not allow_values('rtv-1234', '1234', 'RTV1234').for(:plate) }
  it { should have_many(:parking_reservations) }

  describe('factory') do
    describe('is_valid?') do
      let(:vehicle) { FactoryBot.build(:vehicle) }
      it { expect(vehicle.valid?).to be true }
    end
  end
end

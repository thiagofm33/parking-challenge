require "rails_helper"

RSpec.describe 'Parking Routes', type: :routing do
  it 'routes POST /parking to parking#check_in' do
    expect(post: '/parking').to route_to('parking#check_in')
  end
end

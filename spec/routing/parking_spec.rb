require "rails_helper"

RSpec.describe 'Parking Routes', type: :routing do
  it 'routes POST /parking to parking#check_in' do
    expect(post: '/parking').to route_to('parking#check_in')
  end

  it 'routes PUT|PATCH /parking/:id/pay to parking#make_payment' do
    expect(put: '/parking/3/pay').to route_to('parking#make_payment', id: '3')
    expect(patch: '/parking/3/pay').to route_to('parking#make_payment', id: '3')
  end

  it 'routes PUT|PATCH /parking/:id/out to parking#check_out' do
    expect(put: '/parking/3/out').to route_to('parking#check_out', id: '3')
    expect(patch: '/parking/3/out').to route_to('parking#check_out', id: '3')
  end

  it 'routes GET /parking/:plate to parking#vehicle_history via GET' do
    expect(get: '/parking/AAA-0000').to route_to('parking#vehicle_history', plate: 'AAA-0000')
  end
end

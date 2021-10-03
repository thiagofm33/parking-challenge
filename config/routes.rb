Rails.application.routes.draw do

  scope 'parking', controller: 'parking' do
    post '/', action: 'check_in', as: :check_in

    get ':plate', action: 'vehicle_history', as: :history,
      constraints: { plate: /[A-Z]{3}\-\d{4}/ }
  end

end

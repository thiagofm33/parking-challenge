Rails.application.routes.draw do

  scope 'parking', controller: 'parking' do
    post '/', action: 'check_in', as: :check_in
  end

end

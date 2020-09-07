Rails.application.routes.draw do

  root 'home#dashboard'
  mount Api => '/'

  resources :appointments
  resources :patients
  resources :doctors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

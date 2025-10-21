Rails.application.routes.draw do
 root "listings#index"

  resources :listings do
    resources :images,   only: [:index]   # /listings/:listing_id/images
    resources :reviews,  only: [:index, :new, :create, :edit, :update]   # /listings/:listing_id/reviews
    resources :bookings, only: [:index, :new, :create, :destroy]   # /listings/:listing_id/bookings
  end

  resources :users, only: [:index, :show]

  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end

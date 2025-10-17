Rails.application.routes.draw do
 root "listings#index"

  resources :listings do
    resources :images,   only: [:index]   # /listings/:listing_id/images
    resources :reviews,  only: [:index, :new, :create, :edit, :update]   # /listings/:listing_id/reviews
    resources :bookings, only: [:index]   # /listings/:listing_id/bookings
  end

  resources :users, only: [:index, :show]
end

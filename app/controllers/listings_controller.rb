class ListingsController < ApplicationController
  def index
    @listings = Listing.includes(:images, :reviews).order(created_at: :desc)
  end

  def show
    @listing = Listing.find(params[:id])
    @owner   = @listing.user
    @images  = @listing.images.limit(10)
    @reviews = @listing.reviews.includes(:user).order(created_at: :desc).limit(10)
  end
end

class ReviewsController < ApplicationController
  def index
    @listing = Listing.find(params[:listing_id])
    @reviews = @listing.reviews.includes(:user).order(created_at: :desc)
  end
end

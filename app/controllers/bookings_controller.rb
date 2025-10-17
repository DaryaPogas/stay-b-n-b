class BookingsController < ApplicationController
  def index
    @listing  = Listing.find(params[:listing_id])
    @bookings = @listing.bookings.includes(:user).order(start_date: :asc)
  end
end

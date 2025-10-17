class ImagesController < ApplicationController
  def index
    @listing = Listing.find(params[:listing_id])
    @images  = @listing.images.order(created_at: :desc)
  end
end

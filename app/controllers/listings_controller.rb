class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  def index
    @listings = Listing.includes(:images, :reviews).order(created_at: :desc)
  end

  def show
    @owner   = @listing.user
    @images  = @listing.images.limit(10)
    @reviews = @listing.reviews.includes(:user).order(created_at: :desc).limit(10)
  end
  def new
    @listing = Listing.new
  end

 def create
  @listing = Listing.new(listing_params.except(:image_url).merge(user: demo_user))
  if @listing.save
    if listing_params[:image_url].present?
      @listing.images.create(image_url: listing_params[:image_url])
    end
    redirect_to @listing, notice: "Listing created."
  else
    flash.now[:alert] = @listing.errors.full_messages.to_sentence
    render :new, status: :unprocessable_entity
  end
end


  def edit; end

 def update
  if @listing.update(listing_params.except(:image_url))
    if listing_params[:image_url].present?
      @listing.images.destroy_all
      @listing.images.create(image_url: listing_params[:image_url])
    end
    redirect_to @listing, notice: "Listing updated."
  else
    flash.now[:alert] = @listing.errors.full_messages.to_sentence
    render :edit, status: :unprocessable_entity
  end
end


  def destroy
    @listing.destroy
    redirect_to listings_path, notice: "Listing removed."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :image_url)
  end

  
  def demo_user
    User.first || User.create!(name: "Demo", email: "demo@example.com")
end
end

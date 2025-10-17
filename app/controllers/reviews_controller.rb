class ReviewsController < ApplicationController
  before_action :set_listing
  before_action :set_review, only: [:edit, :update]
  def index
    @reviews = @listing.reviews.includes(:user).order(created_at: :desc)
  end

  def new
    @review = @listing.reviews.new
  end

  def create
    @review = @listing.reviews.new(review_params.merge(user: demo_user))
    if @review.save
      redirect_to listing_path(@listing), notice: "Review added."
    else
      flash.now[:alert] = @review.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to listing_path(@listing), notice: "Review updated."
    else
      flash.now[:alert] = @review.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_review
    @review = @listing.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def demo_user
    User.first || User.create!(name: "Demo", email: "demo@example.com")
  end
end

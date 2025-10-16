class UsersController < ApplicationController
  def index
    @users = User.order(:name)
  end

  def show
    @user     = User.find(params[:id])
    @listings = @user.listings.order(created_at: :desc)
    @reviews  = @user.reviews.includes(:listing).order(created_at: :desc).limit(10)
  end
end

class BookingsController < ApplicationController
  before_action :set_listing
  before_action :set_booking, only: [:destroy]
  before_action :require_login, only: [:new, :create, :destroy]
  def index
    @bookings = @listing.bookings.includes(:user).order(start_date: :asc)
  end

  def new
    @booking = @listing.bookings.new
  end

  def create
    @booking = @listing.bookings.new(booking_params.merge(user: current_user))
    if @booking.save
      redirect_to listing_bookings_path(@listing), notice: "Booking created."
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to listing_bookings_path(@listing), notice: "Booking cancelled."
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_booking
    @booking = @listing.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

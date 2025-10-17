require "rails_helper"

RSpec.describe "GET routes", type: :request do
  let!(:user)    { User.create!(name: "Owner", email: "owner@example.com") }
  let!(:guest)   { User.create!(name: "Guest", email: "guest@example.com") }
  let!(:listing) { Listing.create!(title: "Cozy Flat", description: "Nice", price: 100, user: user) }
  let!(:image1)  { Image.create!(listing: listing, image_url: "https://example.com/1.jpg") }
  let!(:review1) { Review.create!(user: guest, listing: listing, rating: "5", comment: "Great!") }
  let!(:booking) { Booking.create!(user: guest, listing: listing, start_date: Date.today, end_date: Date.today + 2) }

  describe "root → listings#index" do
    it "responds with 200 and shows listings" do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Listings")
      expect(response.body).to include("Cozy Flat")
    end
  end

  describe "GET /listings" do
    it "lists all listings" do
      get listings_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Cozy Flat")
    end
  end

  describe "GET /listings/:id" do
    it "shows a listing" do
      get listing_path(listing)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Cozy Flat")
      expect(response.body).to include("Great!")
      expect(response.body).to include("https://example.com/1.jpg")
    end
  end

  describe "GET /users" do
    it "lists users" do
      get users_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Owner")
      expect(response.body).to include("Guest")
    end
  end

  describe "GET /users/:id" do
    it "shows a user profile" do
      get user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Owner")
      expect(response.body).to include("owner@example.com")
      expect(response.body).to include("Cozy Flat")
    end
  end

  describe "GET /listings/:listing_id/images" do
    it "shows images for listing" do
      get listing_images_path(listing)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Images for")
      expect(response.body).to include("https://example.com/1.jpg")
    end
  end

  describe "GET /listings/:listing_id/reviews" do
    it "shows reviews for listing" do
      get listing_reviews_path(listing)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Reviews for")
      expect(response.body).to include("Great!")
      expect(response.body).to include("Guest")
    end
  end

  describe "GET /listings/:listing_id/bookings" do
    it "shows bookings for listing" do
      get listing_bookings_path(listing)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Bookings for")
      expect(response.body).to include(booking.start_date.to_s)
      expect(response.body).to include(guest.name)
    end
  end
end

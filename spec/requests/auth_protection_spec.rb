require "rails_helper"

RSpec.describe "Auth protection", type: :request do
  let!(:user)    { User.create!(name: "Owner", email: "owner@example.com", password: "password") }
  let!(:listing) { Listing.create!(title: "Old", description: "D", price: 10, user: user) }

  def login(email:, password:)
    post login_path, params: { email: email, password: password }
    follow_redirect! if response.redirect?
  end

  context "unauthenticated" do
    it "blocks GET /listings/new with 403" do
      get new_listing_path
      expect(response).to have_http_status(:forbidden)
    end

    it "blocks POST /listings with 403" do
      post listings_path, params: { listing: { title: "X", description: "Y", price: 1.0 } }
      expect(response).to have_http_status(:forbidden)
    end

    it "blocks GET /listings/:id/edit with 403" do
      get edit_listing_path(listing)
      expect(response).to have_http_status(:forbidden)
    end

    it "blocks POST /listings/:id/reviews with 403" do
      post listing_reviews_path(listing), params: { review: { rating: "5", comment: "Great" } }
      expect(response).to have_http_status(:forbidden)
    end
  end

  context "authenticated" do
    before { login(email: "owner@example.com", password: "password") }

    it "allows creating a listing" do
      expect {
        post listings_path, params: { listing: { title: "New", description: "Nice", price: 9.99 } }
      }.to change(Listing, :count).by(1)
      expect(response).to redirect_to(Listing.last)
    end

    it "allows editing a listing" do
      patch listing_path(listing), params: { listing: { title: "Updated" } }
      expect(response).to redirect_to(listing)
      expect(listing.reload.title).to eq("Updated")
    end

    it "allows creating a review" do
      expect {
        post listing_reviews_path(listing), params: { review: { rating: "5", comment: "Great" } }
      }.to change(Review, :count).by(1)
      expect(response).to redirect_to(listing_path(listing))
    end
  end
end

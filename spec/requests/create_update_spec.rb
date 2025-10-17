require "rails_helper"

RSpec.describe "Create & Update", type: :request do
  let!(:user)    { User.create!(name: "Owner", email: "owner@example.com") }
  let!(:listing) { Listing.create!(title: "Old", description: "D", price: 10, user: user) }

  describe "Listings" do
    it "creates listing" do
      expect {
        post listings_path, params: {
          listing: { title: "New Place", description: "Nice", price: 99.99 }
        }
      }.to change(Listing, :count).by(1)
      expect(response).to redirect_to(Listing.last)
      follow_redirect!
      expect(response.body).to include("Listing created")
      expect(response.body).to include("New Place")
    end

    it "updates listing" do
      patch listing_path(listing), params: {
        listing: { title: "Updated Title" }
      }
      expect(response).to redirect_to(listing)
      follow_redirect!
      expect(response.body).to include("Listing updated")
      expect(listing.reload.title).to eq("Updated Title")
    end
  end

  describe "Reviews" do
    it "creates review" do
      expect {
        post listing_reviews_path(listing), params: {
          review: { rating: "5", comment: "Great!" }
        }
      }.to change(Review, :count).by(1)
      expect(response).to redirect_to(listing_path(listing))
      follow_redirect!
      expect(response.body).to include("Review added")
      expect(response.body).to include("Great!")
    end

    it "updates review" do
      review = Review.create!(user: user, listing: listing, rating: "4", comment: "Ok")
      patch listing_review_path(listing, review), params: {
        review: { comment: "Much better now" }
      }
      expect(response).to redirect_to(listing_path(listing))
      follow_redirect!
      expect(response.body).to include("Review updated")
      expect(listing.reviews.find(review.id).comment).to eq("Much better now")
    end
  end
end

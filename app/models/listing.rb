class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :images, dependent: :destroy
  has_many :reviews
end

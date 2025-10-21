class User < ApplicationRecord
    has_many :listings
    has_many :bookings
    has_many :reviews

    has_many :follows, foreign_key: :following_user_id, dependent: :destroy
    has_many :followed_users, through: :follows, source: :followed_user

    has_many :reverse_follows, class_name: 'Follow', foreign_key: :followed_user_id, dependent: :destroy
    has_many :followers, through: :reverse_follows, source: :following_user

    validates :name,  presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password
end

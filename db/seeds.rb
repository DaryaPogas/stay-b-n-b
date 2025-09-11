# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Booking.delete_all
Review.delete_all
Image.delete_all
Listing.delete_all
Follow.delete_all
User.delete_all

# users
u1 = User.create!(name: 'darya', email: 'darya@gmail.com')
u2 = User.create!(name: 'alex', email: 'alex@gmail.com')
u3 = User.create!(name: 'maria', email: 'maria@gmail.com')

# follows
Follow.create!(following_user: u1, followed_user: u2)
Follow.create!(following_user: u1, followed_user: u3)
Follow.create!(following_user: u2, followed_user: u1)

# listings
l1 = Listing.create!(title: 'Room in Latin Quarter', description: 'Beautiful Room perfect for solo travelers', price: 280, user: u2)
l2 = Listing.create!(title: 'Room in Notre Dame', description: 'A quiet little corner in the heart of Paris', price: 202, user: u3)

# imgs
Image.create!(listing: l1, image_url: 'https://a0.muscache.com/im/pictures/33089515/f075297a_original.jpg?im_w=960')
Image.create!(listing: l2, image_url: 'https://a0.muscache.com/im/pictures/67817c16-1b4f-4887-9610-7b9053c25bd4.jpg?im_w=1200')

# bookings
Booking.create!(user: u1, listing: l1, start_date: Date.today + 2, end_date: Date.today + 5)
Booking.create!(user: u3, listing: l2, start_date: Date.today + 1, end_date: Date.today + 3)

# reviews
Review.create!(user: u1, listing: l1, rating: '5', comment: 'Great place!')
Review.create!(user: u3, listing: l1, rating: '4', comment: 'Clean and cozy.')

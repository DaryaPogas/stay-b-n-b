## 🏠 Stay-b-n-b

**Stay-b-n-b** is a simple Airbnb-style web app built with Ruby on Rails.  
Users can sign up, log in, create listings, make bookings, and leave reviews.

---

### 🚀 Features
- 🔐 User authentication with **bcrypt**
- 🏡 Full CRUD for listings (create, read, update, delete)
- 📸 Image URLs for listings
- 💬 Reviews system
- 📅 Bookings with start and end dates
- 👥 Follow relationships between users (bonus)
- 🛡️ Access control — only the owner can edit or delete their listings

---

### 🧩 Tech Stack
- **Ruby on Rails 8.0**  
- **bcrypt** for authentication  
- **RSpec** for testing  
- **Turbo** for dynamic views  

---

### 💡 Setup Instructions

git clone https://github.com/<your-username>/stay-b-n-b.git

cd stay-b-n-b

bundle install

bin/rails db:reset

bin/rails server

Then open:
👉 http://localhost:3000


👤 Demo Accounts
You can use these seed accounts to log in:

darya@gmail.com - password: 'secret'
maria@gmail.com - password: 'secret'
alex@gmail.com - password: 'secret'

✨ Author
Darya Pogas
Final Project — Code the Dream, 2025

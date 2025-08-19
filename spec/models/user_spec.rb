require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name and email" do
    user=User.create(name:"darya", email:"darya@gmail.com")
    expect(user).to be_valid
end

it 'returns the name for a user' do
  user=User.create(name:'anna')
  expect(user.name).to eq "anna"
end
end
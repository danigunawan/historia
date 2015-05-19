require 'rails_helper'

describe 'a user signs in' do
  let!(:place) { Place.create(
    name: "Borobudur, Indonesia",
    latitude: -7.608,
    longitude: 110.204,
    fact: nil,
    content: "Pamukkale, meaning",
    image: "borobudur-513465_1280.jpg"
  ) }

  let!(:user) { User.create(
     name: "Admin",
     email: "admin@email.com",
     password: "password",
     password_confirmation: "password",
     activated: true
  ) }

  before do
    visit root_url
  end

  it 'signs in successfully' do
    within '.signin-container' do
      fill_in 'email', with: 'admin@email.com'
      fill_in 'password', with: 'password'
      click_button 'Sign in'
    end

    expect(page).to have_content('Sign out')
  end
end
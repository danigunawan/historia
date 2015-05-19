require 'rails_helper'

describe 'a new user signing up' do
  let!(:place) { Place.create(
    name: "Borobudur, Indonesia",
    latitude: -7.608,
    longitude: 110.204,
    fact: nil,
    content: "Pamukkale, meaning",
    image: "borobudur-513465_1280.jpg"
    ) }

  let(:email) { ActionMailer::Base.deliveries.last }
  let(:new_user) { User.last }

  before do
    visit root_url
    page.find('#signin-menu').click
    within '.signup-container' do
      fill_in 'user_name', with: 'Sarah'
      fill_in 'user_email', with: 'test@email.com'
      fill_in 'user_password', with: 'abcd1234'
      fill_in 'user_password_confirmation', with: 'abcd1234'
      click_button 'Sign up'
    end
  end

  it 'allows me to create an account' do
    expect(page).to have_content('Check your email to activate your account.')
  end

  it 'send an activation email' do
    expect(email.subject).to eq('Historia | Activate Your Account')
    expect(email.text_part.to_s).to match('Click the below link to activate your account.')
  end

  describe 'when the user follows the activation link' do

    let(:activation_link) { email.text_part.to_s.match(/http[^\s]+/) }

    before do
      visit activation_link
    end

    it 'informs them that their account has been activated' do
      expect(page).to have_content('Account activated!')
    end
  end
end


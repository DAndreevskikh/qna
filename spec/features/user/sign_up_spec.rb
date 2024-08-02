require 'rails_helper'

feature 'User can sign up', %q{
  In order to ask questions and write answers
  As an unauthenticated user
  I'd like to be able to sign up
} do

  scenario 'Unauthenticated user tries to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

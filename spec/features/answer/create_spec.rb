require 'rails_helper'

feature 'User can write an answer', %q{
  In order to help with a question
  As an authenticated user
  I'd like to be able to write an answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'writes an answer' do
      fill_in 'Body', with: 'Test answer'
      click_on 'Post your answer'

      expect(page).to have_content 'Your answer was successfully posted'
      expect(page).to have_content 'Test answer'
    end

    scenario 'writes an answer with errors' do
      fill_in 'Body', with: ''
      click_on 'Post your answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to write an answer' do
    visit question_path(question)

    expect(page).to_not have_selector("input[type=submit][value='Post your answer']")
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end

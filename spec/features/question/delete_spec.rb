require 'rails_helper'

feature 'User can delete their question', %q{
  In order to remove irrelevant or incorrect information
  As an authenticated user
  I'd like to be able to delete my question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_question) { create(:question, user: other_user) }

  scenario 'Authenticated user deletes their question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'

    expect(page).to have_content 'Your question was successfully deleted.'
    expect(page).to_not have_content question.title
  end

  scenario 'Authenticated user tries to delete someone else\'s question' do
    sign_in(user)
    visit question_path(other_question)

    expect(page).to_not have_link 'Delete question'
  end
end

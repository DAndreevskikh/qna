require 'rails_helper'

feature 'User can delete their answer', %q{
  In order to remove irrelevant or incorrect information
  As an authenticated user
  I'd like to be able to delete my answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user, body: 'MyAnswer') }
  given(:other_user) { create(:user) }
  given!(:other_answer) { create(:answer, question: question, user: other_user, body: 'OtherAnswer') }

  scenario 'Authenticated user deletes their answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to have_content 'Your answer was successfully deleted.'
    expect(page).to_not have_content 'MyAnswer'
  end

  scenario 'Authenticated user tries to delete someone else\'s answer' do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Delete answer', href: question_answer_path(question, other_answer)
  end
end

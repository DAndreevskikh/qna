require 'rails_helper'

feature 'User can view questions list', %q{
  In order to find a question
  As a user
  I'd like to be able to view the list of questions
} do

  given!(:questions) { create_list(:question, 3) }

  scenario 'User views questions list' do
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end

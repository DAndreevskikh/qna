require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect {
          post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        }.to change(question.answers, :count).by(1)
      end

      it 'redirects to the question show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new answer in the database' do
        expect {
          post :create, params: { question_id: question.id, answer: attributes_for(:answer, body: nil) }
        }.to_not change(question.answers, :count)
      end

      it 're-renders the question show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, body: nil) }
        expect(response).to render_template 'questions/show'
      end
    end
  end
end

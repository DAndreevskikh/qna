class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :set_answer, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @answer = @question.answers.build(answer_params.merge(user: current_user))
    if @answer.save
      redirect_to @question, notice: 'Your answer was successfully posted'
    else
      flash.now[:alert] = @answer.errors.full_messages.to_sentence
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question, notice: 'Your answer was successfully deleted.'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def authorize_user!
    redirect_to @question, alert: 'You are not authorized to perform this action.' unless @answer.user == current_user
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end

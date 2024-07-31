class AnswersController < ApplicationController
  before_action :set_question

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:destroy]
  helper_method :question

  def index
    @questions = Question.all
  end

  def show
    @question = question
  end

  def new
    @question = Question.new
  end

  def edit
    @question = question
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question was successfully created'
    else
      render :new
    end
  end

  def update
    @question = question
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question = question
    @question.destroy
    redirect_to questions_path, notice: 'Your question was successfully deleted.'
  end

  private

  def question
    @question = params[:id] ? Question.find(params[:id]) : Question.new
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def authorize_user!
    redirect_to questions_path, alert: 'You are not authorized to perform this action.' unless question.user == current_user
  end
end

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
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
    @question = Question.new(question_params)

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
    redirect_to questions_path
  end

  private

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end

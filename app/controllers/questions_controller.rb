class QuestionsController < ApplicationController
  #REFACTORING - this method occurs before the action is done and it is ideally private. to reduce repeition of code
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :destroy, :update, :new]
  before_action :authorize!, only: [:destroy, :update, :edit]

  def new
    @question = Question.new
  end

  def create
    # questions_params = params.require(:question).permit([:title,:body]) #refactored
    #{title: "salfsad", body: "alsdfj"} above is a strong parameter that allows mass-assigning the attributes that we want user to set
    @question = Question.new questions_params
    @question.user = current_user
    if @question.save
      # render :show
      flash[:notice] = "Question created successfully"
      redirect_to @question
    else
      render :new
    end
  end

  def show
    # @question = Question.find params[:id] #refactored
    @answer = Answer.new
  end

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html {render}
      format.json {render json: @questions}
    end
  end

  def edit
    # @question = Question.find params[:id] #refactored
  end

  def update
  @question.slug = nil
  # @question = Question.find params[:id] #refactored
  if @question.update questions_params
    # params.require(:question).permit([:title, :body])
    redirect_to question_path(@question)
  else
    render :edit
  end
  end

  def destroy
    # question = Question.find params[:id] #not not due to refactoring
    @question.destroy # add a @ question
    redirect_to questions_path
  end

  private

  def find_question
    @question = Question.friendly.find params[:id]
  end

  def questions_params
        params.require(:question).permit([:title,:body, {tag_ids: []}])
  end

  def authorize!
        redirect_to root_path, alert: "access denied" unless @question.user == current_user
  end

    def user_vote
      @user_vote ||= @question.vote_for current_user
    end
    helper_method :user_vote
end

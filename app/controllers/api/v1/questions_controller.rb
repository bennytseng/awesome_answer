class Api::V1::QuestionsController < Api::BaseController

  before_action :authenticate_api_user

  QUESTIONS_PER_PAGE = 10
  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(QUESTIONS_PER_PAGE)
    # render json: @questions
  end

  def show
    question = Question.friendly.find params[:id]
    render json: question
  end

  private

  def authenticate_api_user
    user = User.find_by_api_key params[:api_key]
    head :unauthorized unless user
  end

# API KEY GENERATION
# RAILS C > User.all.each {|x| x.send(:generate_api_key) & x.save}

end

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find params[:question_id]
    like = Like.new user: current_user, question: question
    if like.save
      redirect_to question_path(question), notice: "thanks for liking!"
    else
      redirect_to question_path(question), alert: like.errors.full_messages.join(", ")
    end
  end

  def destroy
    question = Question.find params[:question_id]
    like = Like.find params[:id]
    like.destroy
    redirect_to question_path(question), notice: "Unliked!"
  end
end

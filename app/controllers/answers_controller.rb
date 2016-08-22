class AnswersController < ApplicationController
  def create
    answer = Answer.new params.require(:answer).permit(:body)
    question = Question.find params[:question_id]
    answer.question = question
    answer.save
    redirect_to question_path(question), notice: "Answer created!"
  end
end

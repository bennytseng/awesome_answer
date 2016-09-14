# refer to jbuilder documentation. we are passing an array
json.array! @questions do |question|
  json.id question.id
  json.title question.title.titleize
  json.created_on question.created_at.strftime("%Y-%m-%d")
  json.answers question.answers do |answer|
    json.answer_id answer.id
    json.answer_body answer.body
  end 
  json.user do
    json.first_name question.user_first_name
    json.last_name question.user_last_name
  end

end

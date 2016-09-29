# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_names = [
  'lizzi',
  'todd',
  'charlie',
  'fred',
  'james',
  'brian',
  'bob',
  'alice',
]

user_names.each { |name| User.create(user_name: name) }

titles = [
  'Color',
  'Monty Python',
  'Ambiguity'
]

titles.each do |title|
  Poll.create(title: title, author_id: user_names.length)
end

questions = [
  "What's your favorite color?",
  "What is your favorite swallow?",
  "Is the answer to this question true or false?",
  "What is the meaning?",
  "How long is a piece of string this color?"
]

Question.create(text: questions[0], poll_id: 1)
Question.create(text: questions[1], poll_id: 2)

questions.drop(2).each_with_index do |question, i|
  Question.create(text: question, poll_id: 3)
end

AnswerChoice.create(text: "Blue", question_id: 1)
AnswerChoice.create(text: "Green", question_id: 1)
AnswerChoice.create(text: "African", question_id: 2)
AnswerChoice.create(text: "European", question_id: 2)
AnswerChoice.create(text: "True", question_id: 3)
AnswerChoice.create(text: "False", question_id: 3)
AnswerChoice.create(text: "Six", question_id: 4)
AnswerChoice.create(text: "Forty-two", question_id: 4)
AnswerChoice.create(text: "Mountains", question_id: 4)
AnswerChoice.create(text: "Trouble", question_id: 4)
AnswerChoice.create(text: "NaN", question_id: 5)
AnswerChoice.create(text: "-NaN", question_id: 5)
AnswerChoice.create(text: "DIV/0", question_id: 5)
AnswerChoice.create(text: "Five Meters", question_id: 5)

Response.create(user_id: 1, answer_id: 1)
Response.create(user_id: 1, answer_id: 5)
Response.create(user_id: 1, answer_id: 6)
Response.create(user_id: 1, answer_id: 11)
Response.create(user_id: 1, answer_id: 13)
Response.create(user_id: 2, answer_id: 14)
Response.create(user_id: 2, answer_id: 10)
Response.create(user_id: 2, answer_id: 7)
Response.create(user_id: 2, answer_id: 4)
Response.create(user_id: 2, answer_id: 2)

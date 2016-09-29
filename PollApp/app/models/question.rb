class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    results = {}

    response_counts = answer_choices
            .joins("LEFT JOIN responses ON responses.answer_id = answer_choices.id")
            .select("answer_choices.text AS answer, COUNT(responses.id) AS count")
            .group("answer_choices.id")

    response_counts.each do |response|
      results[response.answer] = response.count
    end

    results
  end
end

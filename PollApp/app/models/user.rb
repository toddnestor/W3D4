class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  has_many :polls,
    Proc.new { distinct },
    through: :responses,
    source: :poll

  def completed_polls
    Poll.joins(:questions => :answer_choices)
        .joins("LEFT JOIN responses ON responses.answer_id = answer_choices.id")
        .joins("LEFT JOIN users ON users.id = responses.user_id")
        .where("users.id = :id", {id: self.id})
        .group("polls.id")
        .having("COUNT(questions.id) = COUNT(responses.id)")

        # SELECT
        #   polls.*, COUNT(responses.id), COUNT(questions.id)
        # FROM
        #   polls
        #   LEFT JOIN questions
        #     ON questions.poll_id = polls.id
        #   LEFT JOIN answer_choices
        #     ON answer_choices.question_id = questions.id
        #   LEFT JOIN responses
        #     ON responses.answer_id = answer_choices.id
        # WHERE
        #   responses.user_id = 7
        # GROUP BY
        #   polls.id
        # HAVING
        #   COUNT(questions.id) = COUNT(responses.id);
  end
end

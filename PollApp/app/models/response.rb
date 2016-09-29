class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
  validates_uniqueness_of :user_id, scope: :answer_id

  validate :not_duplicate_response

  def not_duplicate_response
    if respondent_already_answered?
      errors[:duplicate_responses] << "not allowed!"
    end
  end

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question
        .responses
        .where.not(id: @id)
  end

  def respondent_already_answered?
    sibling_responses.where.not(user_id: @user_id).exists?
  end
end

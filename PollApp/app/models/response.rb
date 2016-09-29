class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
  validates_uniqueness_of :user_id, scope: :answer_id

  validate :not_duplicate_response, :not_author_response

  def not_duplicate_response
    if respondent_already_answered?
      errors[:duplicate_responses] << "not allowed!"
    end
  end

  def not_author_response
     if respondent_is_author?
      errors[:author] << "cannot answer own poll!"
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
        .where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.where(user_id: self.user_id).exists?
  end

  def respondent_is_author?
    self.question.poll.author.id == self.user_id
  end
end

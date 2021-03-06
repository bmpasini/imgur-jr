class User < ActiveRecord::Base
  validates :email, presence: true
  validates :username, presence: true
  validates :password, presence: true
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_confirmation_of :password, message: "Password doesn't match"

  has_many :photos
  has_many :comments, through: :photos
  has_many :votes

  has_secure_password

  def already_voted_this?(context, context_type)
    if context_type == "Photo"
      return self.votes.where(votable_type: context_type, votable_id: context.id).first != nil
    else
      return self.votes.where(votable_type: context_type, votable_id: context.id).first != nil
    end
  end
end

class Photo < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true

  has_many :comments
  has_many :votes, as: :votable
  belongs_to :user

  scope :top20,
    select("photos.id, count(votes.id) AS votes_count").
    joins(:votes).
    group("photos.id").
    order("votes_count DESC").
    limit(20)

end

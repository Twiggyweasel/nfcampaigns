class PledgePage < ApplicationRecord
  belongs_to :attendee
  has_one :event, through: :attendee
  has_many :guests, through: :attendee
  has_many :contributions, through: :attendee
  has_many :comments, as: :commentable
  
  validates :goal, presence: true
  
  
  def percent_raised
    if self.attendee.total_raised > 0
      (self.attendee.total_raised / self.goal) * 100
    end
  end
end
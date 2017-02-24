class Team < ApplicationRecord
  belongs_to :event
  has_one :leader,-> { where(is_leader: true, team_id: self) }, :class_name => "Attendee"
  has_many :contributions, as: :backable
  has_many :attendees, inverse_of: :team
  
  
  accepts_nested_attributes_for :attendees, allow_destroy: true
  
  validates :name, presence: true
  
  after_find do
    if Contribution.where(backable_id: self.id, backable_type: "Team", paid: true).where('created_at >= ?', 1.hour.ago).count != 0
      self.update_raised
    end
  end
  
  after_save do
    self.update_raised  
  end
  
  def total_raised
    self.contributions.where(paid: true).pluck(:amount).sum + self.attendees.pluck(:raised).sum
  end
  
  def update_raised
    self.update_column(:raised, total_raised)
  end
  
  paginates_per 6
end

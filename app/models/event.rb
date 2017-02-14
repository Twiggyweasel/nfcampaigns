class Event < ApplicationRecord
  has_many :contributions, as: :backable
  has_many :comments, as: :commentable
  has_many :teams
  has_many :attendees
  has_many :guests, through: :attendees
  has_many :registration_fees
  has_many :event_sizes
  has_many :sizes, through: :event_sizes
  mount_uploader :event_cover, EventCoverUploader
  
  after_find do 
    self.set_active
  end

  def all_attendees
    self.attendees.count + self.guests.count
  end
  
  def total_raised
    self.contributions.pluck(:amount).sum + team_total_raised
  end
  
  def team_total_raised
    
    self.teams.pluck(:raised).sum
  end
  def percent_raised
    if self.raised > 0
      (self.raised/ self.goal) * 100
    end
  end
  
  after_save do 
    self.teams.create( name: "No Team", max_members: 999 , event_id: self.id)
  end
  
  def update_raised
      self.update_column(:raised, total_raised)
  end
  
  def set_active
    if self.registration_date.to_date.past? && self.is_private?
        self.update_column(:is_private, false)
    elsif self.registration_date.to_date.future? && !self.is_private?
        self.update_column(:is_private, true)
    end
  end
end

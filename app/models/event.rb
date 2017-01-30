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


  def all_attendees
    self.attendees.count + self.guests.count
  end
  
  def raised
    self.contributions.pluck(:amount).sum + self.attendees.pluck(:fee).sum + self.guests.pluck(:fee).sum
  end
  
  def percent_raised
    if self.raised > 0
      (self.raised/ self.goal) * 100
    end
  end
  
  after_save do 
    self.teams.create( name: "No Team", max_members: 999 , event_id: self.id)
  end
end
